import 'package:dio/dio.dart';
import 'package:your_recipe/features/profile/data/model/meal_plan.dart';
import 'package:your_recipe/features/profile/data/model/meal_plan_create.dart';

abstract class PlanRemoteDataSource {
  Future<List<MealPlanCreate>> addBulkMealPlan(List<MealPlanCreate> mealPlan);
  Future<List<MealPlan>> getMealPlan(String date);
  Future<MealPlanCreate> addMealPlan(MealPlanCreate mealPlan);
  Future<void> deleteMealPlan(int id);
}

class PlanRemoteDataSourceImpl implements PlanRemoteDataSource {
  final Dio dio;

  PlanRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealPlanCreate>> addBulkMealPlan(List<MealPlanCreate> mealPlans) async {
    try {
      final response = await dio.post(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/meal-plan/bulk-meal-plan/',
        data: mealPlans.map((mealPlan) => mealPlan.toJson()).toList(),
      );

      if (response.statusCode == 201) {
        return (response.data as List)
            .map((mealPlanJson) => MealPlanCreate.fromJson(mealPlanJson))
            .toList();
      } else {
        throw Exception('Failed to add bulk meal plans');
      }
    } catch (e) {
      throw Exception('Error in addBulkMealPlan: $e');
    }
  }

  @override
  Future<MealPlanCreate> addMealPlan(MealPlanCreate mealPlan) async {
    try {
      final response = await dio.post(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/meal-plan/meal-plan/',
        data: mealPlan.toJson(),
      );

      if (response.statusCode == 201) {
        return MealPlanCreate.fromJson(response.data);
      } else {
        throw Exception('Failed to add meal plan');
      }
    } catch (e) {
      throw Exception('Error in addMealPlan: $e');
    }
  }

  @override
  Future<void> deleteMealPlan(int id) async {
    try {
      final response = await dio.delete(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/meal-plan/meal-plan/?id=$id',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete meal plan');
      }
    } catch (e) {
      throw Exception('Error in deleteMealPlan: $e');
    }
  }

  @override
  Future<List<MealPlan>> getMealPlan(String date) async {
    try {
      final response = await dio.get(
        'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/meal-plan/meal-plan/?date=$date',
      );

      if (response.statusCode == 200) {
        var mealPlansList = (response.data as List)
            .map((mealPlanJson) => MealPlan.fromJson(mealPlanJson))
            .toList();
        return mealPlansList;
      } else {
        throw Exception('Failed to fetch meal plan');
      }
    } catch (e) {
      throw Exception('Error in getMealPlan: $e');
    }
  }
}
