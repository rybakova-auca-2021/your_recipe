import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      await registerUseCase(RegisterEntity(email: event.email, password: event.password, confirmPassword: event.confirmPassword));
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError("Register failed: ${e.toString()}"));
    }
  }
}
