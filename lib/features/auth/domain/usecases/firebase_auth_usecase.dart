import 'package:your_recipe/features/auth/data/models/firebase_response_model.dart';
import 'package:your_recipe/features/auth/domain/repositories/auth_repository.dart';
import 'usecase.dart';

class FirebaseAuthUsecase implements UseCase<FirebaseResponseModel, String> {
  final AuthRepository repository;

  FirebaseAuthUsecase(this.repository);

  @override
  Future<FirebaseResponseModel> call(String idToken) async {
    final loginResponse = await repository.firebaseAuth(idToken);

    return FirebaseResponseModel(
      userId: loginResponse.userId,
      accessToken: loginResponse.accessToken,
      refreshToken: loginResponse.refreshToken,
      message: loginResponse.message
    );
  }
}

