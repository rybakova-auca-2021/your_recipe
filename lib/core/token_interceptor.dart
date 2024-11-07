import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  Dio dio;

  TokenInterceptor(this.dio);

  /// Retrieves the refresh token from SharedPreferences.
  Future<String?> _getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  /// Saves the new access token in SharedPreferences.
  Future<void> _setAccessToken(String newToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', newToken);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshAccessToken();

      if (newToken != null) {
        await _setAccessToken(newToken);

        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';

        final response = await dio.request(
          retryOptions.path,
          options: Options(
            method: retryOptions.method,
            headers: retryOptions.headers,
          ),
          data: retryOptions.data,
          queryParameters: retryOptions.queryParameters,
        );
        return handler.resolve(response);
      }
    }
    handler.next(err);
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken == null) return null;

      final response = await dio.post(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/login/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        return response.data['access'];
      } else {
        return null;
      }
    } catch (e) {
      print('Token refresh failed: $e');
      return null;
    }
  }
}
