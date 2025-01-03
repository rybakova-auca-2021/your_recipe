import '../../data/models/firebase_response_model.dart';
import '../entities/login_entity.dart';
import '../entities/login_response_entity.dart';
import '../entities/register_entity.dart';
import '../entities/password_reset_entity.dart';
import '../entities/password_set_entity.dart';
import '../entities/send_code_entity.dart';
import '../usecases/reset_password_usecase.dart';

abstract class AuthRepository {
  Future<LoginResponseEntity> login(LoginEntity loginEntity);
  Future<FirebaseResponseModel> firebaseAuth(String idToken);
  Future<LoginResponseEntity> register(RegisterEntity registerEntity);
  Future<PasswordResetResponseEntity> resetPassword(PasswordResetEntity passwordResetEntity);
  Future<void> sendCode(SendCodeEntity sendCodeEntity);
  Future<void> setPassword(PasswordSetEntity passwordSetEntity);
}
