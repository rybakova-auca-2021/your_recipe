import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/auth/domain/entities/register_entity.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterRequested>(_onLoginRequested);
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
}
