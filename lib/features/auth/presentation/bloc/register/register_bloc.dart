import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/auth/domain/entities/register_entity.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';

import '../../../domain/usecases/firebase_auth_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  final FirebaseAuthUsecase firebaseAuthUsecase;

  RegisterBloc(this.registerUseCase, this.firebaseAuthUsecase) : super(RegisterInitial()) {
    on<RegisterRequested>(_onLoginRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  Future<void> _onLoginRequested(RegisterRequested event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await registerUseCase(RegisterEntity(email: event.email, password: event.password, confirmPassword: event.confirmPassword));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', response.userId);
      await prefs.setString('accessToken', response.accessToken);
      await prefs.setString('refreshToken', response.refreshToken);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError("Register failed: ${e.toString()}"));
    }
  }

  Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final String idToken = googleAuth.idToken!;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        final response = await firebaseAuthUsecase(idToken);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', response.userId);
        await prefs.setString('accessToken', response.accessToken);
        await prefs.setString('refreshToken', response.refreshToken);
        emit(RegisterSuccess());
      }
    } catch (e) {
      emit(RegisterError("Google Sign-In Failed: ${e.toString()}"));
    }
  }
}
