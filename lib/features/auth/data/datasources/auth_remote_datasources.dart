import 'package:dio/dio.dart';
import 'package:your_recipe/features/auth/data/models/firebase_response_model.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../models/firebase_model.dart';
import '../models/login_model.dart';
import '../models/login_response_model.dart';
import '../models/register_model.dart';
import '../models/password_reset_model.dart';
import '../models/send_code_model.dart';
import '../models/password_set_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginModel loginModel);
  Future<FirebaseResponseModel> firebaseAuth(FirebaseModel loginModel);
  Future<LoginResponseModel> register(RegisterModel registerModel);
  Future<PasswordResetResponseEntity> resetPassword(PasswordResetModel passwordResetModel);
  Future<void> sendCode(SendCodeModel sendCodeModel);
  Future<void> setPassword(PasswordSetModel passwordSetModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/login/',
      data: loginModel.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Login failed');
    }

    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<FirebaseResponseModel> firebaseAuth(FirebaseModel firebaseModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/auth/firebase/',
      data: firebaseModel.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Login with google failed');
    }

    return FirebaseResponseModel.fromJson(response.data);
  }

  @override
  Future<LoginResponseModel> register(RegisterModel registerModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/register-with-email/',
      data: registerModel.toJson(),
    );
    if (response.statusCode != 201) {
      throw Exception('Registration failed');
    }
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<PasswordResetResponseEntity> resetPassword(PasswordResetModel passwordResetModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/reset-password/',
      data: passwordResetModel.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Password reset failed');
    }

    final data = response.data;
    final userId = data['user_id'];
    final resetCode = data['reset_code'];

    if (userId == null || resetCode == null) {
      throw Exception('Invalid response data');
    }

    return PasswordResetResponseEntity(
      userId: userId,
      resetCode: resetCode,
    );
  }

@override
  Future<void> sendCode(SendCodeModel sendCodeModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/send-code/${sendCodeModel.userId}/',
      data: sendCodeModel.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Sending code failed');
    }
  }

  @override
  Future<void> setPassword(PasswordSetModel passwordSetModel) async {
    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/set-new-password/',
      data: passwordSetModel.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('Setting password failed');
    }
  }
}
