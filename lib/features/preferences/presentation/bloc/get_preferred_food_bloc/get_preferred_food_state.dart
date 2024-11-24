part of 'get_preferred_food_bloc.dart';

abstract class GetPreferredFoodState {}

class GetPreferredFoodInitial extends GetPreferredFoodState {}

class GetPreferredFoodLoading extends GetPreferredFoodState {}

class GetPreferredFoodSuccess extends GetPreferredFoodState {
  final List<PreferenceDomain> foods;

  GetPreferredFoodSuccess({required this.foods});
}

class GetPreferredFoodFailure extends GetPreferredFoodState {
  final String error;

  GetPreferredFoodFailure({required this.error});
}
