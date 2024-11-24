part of 'add_food_bloc.dart';

abstract class AddPreferredFoodState {}

class AddPreferredFoodInitial extends AddPreferredFoodState {}

class AddPreferredFoodLoading extends AddPreferredFoodState {}

class AddPreferredFoodSuccess extends AddPreferredFoodState {}

class AddPreferredFoodFailure extends AddPreferredFoodState {
  final String error;

  AddPreferredFoodFailure({required this.error});
}
