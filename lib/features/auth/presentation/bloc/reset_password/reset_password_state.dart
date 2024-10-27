
part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final int userId;
  final String resetCode;

  ResetPasswordSuccess(this.userId, this.resetCode);

  @override
  List<Object?> get props => [userId, resetCode];
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  ResetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
