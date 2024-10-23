part of 'profile_bloc.dart';

abstract class ProfileUpdateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileUpdated extends ProfileUpdateEvent {
  final int id;
  final String? email;
  final String username;
  final String profilePhoto;

  ProfileUpdated(this.id, this.email, this.username, this.profilePhoto);

  @override
  List<Object?> get props => [id, email, username, profilePhoto];
}
