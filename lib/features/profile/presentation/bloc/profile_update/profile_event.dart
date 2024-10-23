part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final int id;

  const FetchProfile(this.id);

  @override
  List<Object> get props => [id];
}
