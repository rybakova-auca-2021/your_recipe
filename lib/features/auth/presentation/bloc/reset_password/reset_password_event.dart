part of 'reset_password_bloc.dart';

abstract class SendCodeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendCodeRequested extends SendCodeEvent {
  final String email;

  SendCodeRequested(this.email);

  @override
  List<Object?> get props => [email];
}
