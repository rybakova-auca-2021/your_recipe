part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess();
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
