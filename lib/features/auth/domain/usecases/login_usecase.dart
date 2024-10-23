import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import 'package:your_recipe/features/auth/domain/repositories/auth_repository.dart';
import 'usecase.dart';

class LoginResult {
  final int userId;

  LoginResult({required this.userId});
}

class LoginUseCase implements UseCase<LoginResult, LoginEntity> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<LoginResult> call(LoginEntity loginEntity) async {
    final userId = await repository.login(loginEntity);
    return LoginResult(userId: userId);
  }
}
