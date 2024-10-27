part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequested(this.email, this.password, this.confirmPassword);

  @override
  List<Object?> get props => [email, password, confirmPassword];
}
