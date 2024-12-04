part of 'meal_plan_bloc.dart';

abstract class MealPlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddBulkMealPlansEvent extends MealPlanEvent {
  final List<MealPlanCreateEntity> mealPlans;

  AddBulkMealPlansEvent(this.mealPlans);

  @override
  List<Object?> get props => [mealPlans];
}

class AddMealPlanEvent extends MealPlanEvent {
  final MealPlanCreateEntity mealPlan;

  AddMealPlanEvent(this.mealPlan);

  @override
  List<Object?> get props => [mealPlan];
}

class DeleteMealPlanEvent extends MealPlanEvent {
  final int id;
  final String date;

  DeleteMealPlanEvent(this.id, this.date);

  @override
  List<Object?> get props => [id, date];
}

class GetMealPlanEvent extends MealPlanEvent {
  final String date;

  GetMealPlanEvent(this.date);

  @override
  List<Object?> get props => [date];
}
