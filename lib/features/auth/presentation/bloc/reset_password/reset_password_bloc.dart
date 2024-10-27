import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_recipe/features/auth/domain/usecases/reset_password_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<SendCodeEvent, ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordBloc(this.resetPasswordUseCase) : super(ResetPasswordInitial()) {
    on<SendCodeRequested>(_onSendCodeRequested);
  }

  Future<void> _onSendCodeRequested(SendCodeRequested event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoading());
    try {
      final response = await resetPasswordUseCase(event.email);
      emit(ResetPasswordSuccess(response.userId, response.resetCode));
    } catch (e) {
      emit(ResetPasswordError("Failed to send code: ${e.toString()}"));
    }
  }
}

