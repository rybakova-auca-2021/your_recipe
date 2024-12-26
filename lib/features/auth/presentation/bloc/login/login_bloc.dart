import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import 'package:your_recipe/features/auth/domain/usecases/firebase_auth_usecase.dart';

import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final FirebaseAuthUsecase firebaseAuthUsecase;

  LoginBloc(this.loginUseCase, this.firebaseAuthUsecase) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase(LoginEntity(email: event.email, password: event.password));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', response.userId);
      await prefs.setString('accessToken', response.accessToken);
      await prefs.setString('refreshToken', response.refreshToken);
      emit(LoginSuccess(response.userId));
    } catch (e) {
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }

  Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
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
        emit(LoginSuccess(response.userId));
      }
    } catch (e) {
      emit(LoginError("Google Sign-In Failed: ${e.toString()}"));
    }
  }
}

