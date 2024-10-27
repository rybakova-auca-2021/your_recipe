import 'package:your_recipe/features/auth/domain/entities/register_entity.dart';

import '../repositories/auth_repository.dart';
import 'usecase.dart';

class RegisterUseCase implements UseCase<void, RegisterEntity> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<void> call(RegisterEntity registerEntity) {
    return repository.register(registerEntity);
  }
}
