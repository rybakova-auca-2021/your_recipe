import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import 'package:your_recipe/features/auth/domain/repositories/auth_repository.dart';
import 'usecase.dart';

class LoginUseCase implements UseCase<void, LoginEntity> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<void> call(LoginEntity loginEntity) async {
    await repository.login(loginEntity);
  }
}
