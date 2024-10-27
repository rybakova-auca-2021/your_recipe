import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_recipe/features/auth/domain/entities/login_entity.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    // Registering the event handler for LoginRequested
    on<LoginRequested>(_onLoginRequested);
  }

  // Method to handle LoginRequested event
  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await loginUseCase(LoginEntity(email: event.email, password: event.password));
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }
}
