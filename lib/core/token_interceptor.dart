import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  Dio dio;

  TokenInterceptor(this.dio);

  Completer<String?>? _refreshCompleter;

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshTokenIfNeeded();

        if (newToken != null) {
          await _setAccessToken(newToken);

          // Retry the failed request with the new token
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
      } catch (e) {
        print('Token refresh failed: $e');
      }
    }

    handler.next(err);
  }

  /// Refreshes the access token only once for concurrent requests.
  Future<String?> _refreshTokenIfNeeded() async {
    if (_refreshCompleter != null) {
      return await _refreshCompleter!.future; // Wait for the ongoing refresh.
    }

    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter?.complete(null);
        _refreshCompleter = null;
        return null;
      }

      final response = await dio.post(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/login/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        _refreshCompleter?.complete(newAccessToken);
        _refreshCompleter = null;
        return newAccessToken;
      } else {
        _refreshCompleter?.complete(null);
        _refreshCompleter = null;
        return null;
      }
    } catch (e) {
      _refreshCompleter?.completeError(e);
      _refreshCompleter = null;
      return null;
    }
  }
}
