import 'package:your_recipe/features/auth/domain/entities/register_entity.dart';

import '../entities/login_response_entity.dart';
import '../repositories/auth_repository.dart';
import 'usecase.dart';

class RegisterUseCase implements UseCase<LoginResponseEntity, RegisterEntity> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<LoginResponseEntity> call(RegisterEntity registerEntity) {
    return repository.register(registerEntity);
  }
}
