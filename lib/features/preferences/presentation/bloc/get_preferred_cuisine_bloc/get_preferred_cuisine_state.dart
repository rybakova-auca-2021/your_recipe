part of 'get_preferred_cuisine_bloc.dart';

abstract class GetPreferredCuisineState {}

class GetPreferredCuisineInitial extends GetPreferredCuisineState {}

class GetPreferredCuisineLoading extends GetPreferredCuisineState {}

class GetPreferredCuisineSuccess extends GetPreferredCuisineState {
  final List<PreferenceDomain> cuisines;

  GetPreferredCuisineSuccess({required this.cuisines});
}

class GetPreferredCuisineFailure extends GetPreferredCuisineState {
  final String error;

  GetPreferredCuisineFailure({required this.error});
}
