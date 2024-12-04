import '../../data/model/meal_plan_create.dart';

class MealPlanCreateEntity {
  final String date;
  final String mealType;
  final int recipe;

  MealPlanCreateEntity({
    required this.date,
    required this.mealType,
    required this.recipe,
  });
}

extension MealPlanCreateMapper on MealPlanCreateEntity {
  MealPlanCreate toModel() {
    return MealPlanCreate(
      date: date,
      mealType: mealType,
      recipe: recipe,
    );
  }
}

extension MealPlanCreateModelMapper on MealPlanCreate {
  MealPlanCreateEntity toEntity() {
    return MealPlanCreateEntity(
      date: date,
      mealType: mealType,
      recipe: recipe,
    );
  }
}
