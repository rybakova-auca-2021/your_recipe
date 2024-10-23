
part of 'profile_bloc.dart';

abstract class ProfileUpdateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {
  ProfileUpdateSuccess();
}

class ProfileUpdateError extends ProfileUpdateState {
  final String message;

  ProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}
