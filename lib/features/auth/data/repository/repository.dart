import 'package:your_recipe/features/auth/data/models/login_model.dart';
import 'package:your_recipe/features/auth/data/models/register_model.dart';
import 'package:your_recipe/features/auth/data/models/password_reset_model.dart';
import 'package:your_recipe/features/auth/data/models/password_set_model.dart';
import 'package:your_recipe/features/auth/data/models/send_code_model.dart';
import 'package:your_recipe/features/auth/domain/entities/login_response_entity.dart';
import 'package:your_recipe/features/auth/domain/usecases/reset_password_usecase.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/password_reset_entity.dart';
import '../../domain/entities/password_set_entity.dart';
import '../../domain/entities/send_code_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginResponseEntity> login(LoginEntity loginEntity) async {
    final loginModel = LoginModel(
      email: loginEntity.email,
      password: loginEntity.password,
    );
    final loginResponseModel = await remoteDataSource.login(loginModel);
    return LoginResponseEntity(
      userId: loginResponseModel.userId,
      accessToken: loginResponseModel.accessToken,
      refreshToken: loginResponseModel.refreshToken,
    );
  }

  @override
  Future<LoginResponseEntity> register(RegisterEntity registerEntity) async {
    final registerModel = RegisterModel(
      email: registerEntity.email,
      password: registerEntity.password,
      confirmPassword: registerEntity.confirmPassword,
    );
    final registerResponseModel = await remoteDataSource.register(registerModel);
    return LoginResponseEntity(
      userId: registerResponseModel.userId,
      accessToken: registerResponseModel.accessToken,
      refreshToken: registerResponseModel.refreshToken,
    );
  }

  @override
  Future<PasswordResetResponseEntity> resetPassword(PasswordResetEntity passwordResetEntity) async {
    final passwordResetModel = PasswordResetModel(email: passwordResetEntity.email);
    final response = await remoteDataSource.resetPassword(passwordResetModel);
    return response;
  }

  @override
  Future<void> sendCode(SendCodeEntity sendCodeEntity) async {
    final sendCodeModel = SendCodeModel(code: sendCodeEntity.code, userId: sendCodeEntity.userId);
    await remoteDataSource.sendCode(sendCodeModel);
  }

  @override
  Future<void> setPassword(PasswordSetEntity passwordSetEntity) async {
    final passwordSetModel = PasswordSetModel(
      userId: passwordSetEntity.userId,
      newPassword: passwordSetEntity.newPassword,
      confirmPassword: passwordSetEntity.confirmPassword,
    );
    await remoteDataSource.setPassword(passwordSetModel);
  }
}
