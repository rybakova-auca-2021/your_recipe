import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/profile/domain/entities/profile_entity.dart';
import 'package:your_recipe/features/profile/domain/usecases/fetch_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchProfileUsecase fetchProfileUsecase;

  ProfileBloc(this.fetchProfileUsecase) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await fetchProfileUsecase(event.id);
      emit(ProfileFetchSuccess(profile));
    } catch (e) {
      emit(ProfileError("Fetching profile failed: ${e.toString()}"));
    }
  }
}
