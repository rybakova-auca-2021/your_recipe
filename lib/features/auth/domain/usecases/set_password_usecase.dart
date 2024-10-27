import 'package:your_recipe/features/auth/domain/entities/password_set_entity.dart';

import '../repositories/auth_repository.dart';
import 'usecase.dart';

class SetPasswordUseCase implements UseCase<void, SetPasswordParams> {
  final AuthRepository repository;

  SetPasswordUseCase(this.repository);

  @override
  Future<void> call(SetPasswordParams params) {
    return repository.setPassword(
      PasswordSetEntity(
        userId: params.userId,
        newPassword: params.newPassword,
        confirmPassword: params.confirmPassword)
    );
  }
}

class SetPasswordParams {
  final String userId;
  final String newPassword;
  final String confirmPassword;

  SetPasswordParams({
    required this.userId,
    required this.newPassword,
    required this.confirmPassword,
  });
}
