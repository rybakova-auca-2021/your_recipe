import '../../../main/domain/entity/recipe_detail_entity.dart';
import '../../data/model/meal_plan.dart';

class MealPlanEntity {
  final int id;
  final String date;
  final String mealType;
  final RecipeDetailEntity recipe;

  MealPlanEntity({
    required this.id,
    required this.date,
    required this.mealType,
    required this.recipe,
  });
}

extension MealPlanMapper on MealPlanEntity {
  MealPlan toModel() {
    return MealPlan(
      id: id,
      date: date,
      mealType: mealType,
      recipe: recipe.toModel(),
    );
  }
}

extension MealPlanModelMapper on MealPlan {
  MealPlanEntity toEntity() {
    return MealPlanEntity(
      id: id,
      date: date,
      mealType: mealType,
      recipe: recipe.toEntity(),
    );
  }
}
