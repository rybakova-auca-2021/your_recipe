part of 'code_verification_bloc.dart';

abstract class CodeVerificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CodeVerificationRequested extends CodeVerificationEvent {
  final String code;
  final String userId;

  CodeVerificationRequested(this.code, this.userId);

  @override
  List<Object?> get props => [code, userId];
}
