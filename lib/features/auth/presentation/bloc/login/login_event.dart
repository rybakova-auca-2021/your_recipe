part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}


class FirebaseAuthRequested extends LoginEvent {
  final String idToken;

  FirebaseAuthRequested(this.idToken);

  @override
  List<Object?> get props => [idToken];
}

class GoogleSignInRequested extends LoginEvent {}
