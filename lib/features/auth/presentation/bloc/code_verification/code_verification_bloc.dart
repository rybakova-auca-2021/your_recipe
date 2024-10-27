import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:your_recipe/features/auth/domain/usecases/send_code_usecase.dart';

part 'code_verification_event.dart';
part 'code_verification_state.dart';

class CodeVerificationBloc extends Bloc<CodeVerificationEvent, CodeVerificationState> {
  final SendCodeUseCase sendCodeUseCase;

  CodeVerificationBloc(this.sendCodeUseCase) : super(CodeVerificationInitial()) {
    on<CodeVerificationRequested>(_onCodeVerificationRequested);
  }

  Future<void> _onCodeVerificationRequested(CodeVerificationRequested event, Emitter<CodeVerificationState> emit) async {
    emit(CodeVerificationLoading());
    try {
      await sendCodeUseCase(SendCodeParams(code: event.code, userId: event.userId as String));
      emit(CodeVerificationSuccess());
    } catch (e) {
      emit(CodeVerificationError("Failed to check code: ${e.toString()}"));
    }
  }
}
