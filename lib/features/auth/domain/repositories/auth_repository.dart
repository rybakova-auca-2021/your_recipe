import '../entities/login_entity.dart';
import '../entities/register_entity.dart';
import '../entities/password_reset_entity.dart';
import '../entities/password_set_entity.dart';
import '../entities/send_code_entity.dart';
import '../usecases/reset_password_usecase.dart';

abstract class AuthRepository {
  Future<int> login(LoginEntity loginEntity);
  Future<void> register(RegisterEntity registerEntity);
  Future<PasswordResetResponseEntity> resetPassword(PasswordResetEntity passwordResetEntity);
  Future<void> sendCode(SendCodeEntity sendCodeEntity);
  Future<void> setPassword(PasswordSetEntity passwordSetEntity);
}
