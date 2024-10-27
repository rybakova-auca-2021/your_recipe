
part of 'code_verification_bloc.dart';

abstract class CodeVerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CodeVerificationInitial extends CodeVerificationState {}

class CodeVerificationLoading extends CodeVerificationState {}

class CodeVerificationSuccess extends CodeVerificationState {
  CodeVerificationSuccess();
}

class CodeVerificationError extends CodeVerificationState {
  final String message;

  CodeVerificationError(this.message);

  @override
  List<Object?> get props => [message];
}
