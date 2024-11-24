part of 'fetch_cuisine_bloc.dart';

abstract class FetchCuisineState {}

class FetchCuisineInitial extends FetchCuisineState {}

class FetchCuisineLoading extends FetchCuisineState {}

class FetchCuisineSuccess extends FetchCuisineState {
  final List<PreferenceDomain> cuisines;

  FetchCuisineSuccess({required this.cuisines});
}

class FetchCuisineFailure extends FetchCuisineState {
  final String error;

  FetchCuisineFailure({required this.error});
}
