part of 'meal_plan_bloc.dart';

abstract class MealPlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealPlanInitial extends MealPlanState {}

class MealPlanLoading extends MealPlanState {}

class MealPlanSuccess extends MealPlanState {
  final dynamic data;

  MealPlanSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class MealPlanFailure extends MealPlanState {
  final String message;

  MealPlanFailure(this.message);

  @override
  List<Object?> get props => [message];
}
