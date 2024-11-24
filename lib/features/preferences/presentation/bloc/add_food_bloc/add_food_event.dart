part of 'add_food_bloc.dart';

abstract class AddPreferredFoodEvent {}

class SubmitPreferredFoodEvent extends AddPreferredFoodEvent {
  final List<int> foodIds;

  SubmitPreferredFoodEvent({required this.foodIds});
}
