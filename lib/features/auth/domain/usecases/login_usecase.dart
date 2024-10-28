import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import 'package:your_recipe/features/auth/domain/entities/login_response_entity.dart';
import 'package:your_recipe/features/auth/domain/repositories/auth_repository.dart';
import 'usecase.dart';

class LoginUseCase implements UseCase<LoginResponseEntity, LoginEntity> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<LoginResponseEntity> call(LoginEntity loginEntity) async {
    final loginResponse = await repository.login(loginEntity);

    return LoginResponseEntity(
      userId: loginResponse.userId,
      accessToken: loginResponse.accessToken,
      refreshToken: loginResponse.refreshToken,
    );
  }
}

