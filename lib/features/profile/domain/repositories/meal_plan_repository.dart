import 'package:your_recipe/features/profile/domain/entities/meal_plan_create_entity.dart';
import 'package:your_recipe/features/profile/domain/entities/meal_plan_entity.dart';

abstract class PlanRepository {
  Future<List<MealPlanCreateEntity>> addBulkMealPlan(List<MealPlanCreateEntity> mealPlan);
  Future<List<MealPlanEntity>> getMealPlan(String date);
  Future<MealPlanCreateEntity> addMealPlan(MealPlanCreateEntity mealPlan);
  Future<void> deleteMealPlan(int id);
}