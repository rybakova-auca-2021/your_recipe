import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/profile/domain/entities/profile_entity.dart';
import 'package:your_recipe/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final UpdateProfileUseCase profileUseCase;

  ProfileUpdateBloc(this.profileUseCase) : super(ProfileUpdateInitial()) {
    on<ProfileUpdated>(_onProfileUpdated);
  }

  Future<void> _onProfileUpdated(ProfileUpdated event, Emitter<ProfileUpdateState> emit) async {
    emit(ProfileUpdateLoading());
    try {
      await profileUseCase(ProfileEntity(email: event.email, username: event.username, profilePhoto: event.profilePhoto, id: event.id));
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileUpdateError("Profile failed: ${e.toString()}"));
    }
  }
}
