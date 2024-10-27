
part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {
  UpdatePasswordSuccess();
}

class UpdatePasswordError extends UpdatePasswordState {
  final String message;

  UpdatePasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
