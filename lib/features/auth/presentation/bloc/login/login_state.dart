
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final int userId;

  LoginSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
