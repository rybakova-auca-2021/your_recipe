import 'package:your_recipe/features/auth/domain/entities/send_code_entity.dart';
import '../repositories/auth_repository.dart';
import 'usecase.dart';

class SendCodeUseCase implements UseCase<void, SendCodeParams> {
  final AuthRepository repository;

  SendCodeUseCase(this.repository);

  @override
  Future<void> call(SendCodeParams params) {
    return repository.sendCode(SendCodeEntity(code: params.code, userId: params.userId));
  }
}

class SendCodeParams {
  final String code;
  final String userId;

  SendCodeParams({required this.code, required this.userId});
}
