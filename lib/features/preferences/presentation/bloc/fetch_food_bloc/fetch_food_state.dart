part of 'fetch_food_bloc.dart';

abstract class FetchFoodState {}

class FetchFoodInitial extends FetchFoodState {}

class FetchFoodLoading extends FetchFoodState {}

class FetchFoodSuccess extends FetchFoodState {
  final List<PreferenceDomain> cuisines;

  FetchFoodSuccess({required this.cuisines});
}

class FetchFoodFailure extends FetchFoodState {
  final String error;

  FetchFoodFailure({required this.error});
}
