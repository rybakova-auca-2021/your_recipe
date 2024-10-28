import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase(LoginEntity(email: event.email, password: event.password));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', response.userId);
      await prefs.setString('accessToken', response.accessToken);
      print("access ${response.accessToken}");
      emit(LoginSuccess(response.userId));
    } catch (e) {
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }
}

