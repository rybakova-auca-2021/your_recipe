import 'dart:ffi';

import 'package:your_recipe/features/auth/domain/entities/password_reset_entity.dart';

import '../repositories/auth_repository.dart';
import 'usecase.dart';

class ResetPasswordUseCase implements UseCase<PasswordResetResponseEntity, String> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<PasswordResetResponseEntity> call(String email) async {
    return await repository.resetPassword(PasswordResetEntity(email: email));
  }
}


class PasswordResetResponseEntity {
  final int userId;
  final String resetCode;

  PasswordResetResponseEntity({
    required this.userId,
    required this.resetCode,
  });
}
