part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePasswordRequested extends UpdatePasswordEvent {
  final String password;
  final String newPassword;
  final String userId;

  UpdatePasswordRequested(this.password, this.newPassword, this.userId);

  @override
  List<Object?> get props => [password, newPassword, userId];
}
