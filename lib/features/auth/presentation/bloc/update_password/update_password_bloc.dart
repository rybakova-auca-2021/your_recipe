import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_recipe/features/auth/domain/usecases/set_password_usecase.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final SetPasswordUseCase setPasswordUseCase;

  UpdatePasswordBloc(this.setPasswordUseCase) : super(UpdatePasswordInitial()) {
    on<UpdatePasswordRequested>(_onCodeVerificationRequested);
  }

  Future<void> _onCodeVerificationRequested(UpdatePasswordRequested event, Emitter<UpdatePasswordState> emit) async {
    emit(UpdatePasswordLoading());
    try {
      await setPasswordUseCase(SetPasswordParams(newPassword: event.password, confirmPassword: event.newPassword, userId: event.userId));
      emit(UpdatePasswordSuccess());
    } catch (e) {
      emit(UpdatePasswordError("Failed to update password: ${e.toString()}"));
    }
  }
}
