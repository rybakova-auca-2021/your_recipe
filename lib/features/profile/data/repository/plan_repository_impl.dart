import 'package:your_recipe/features/profile/domain/entities/meal_plan_create_entity.dart';
import 'package:your_recipe/features/profile/domain/entities/meal_plan_entity.dart';
import 'package:your_recipe/features/profile/domain/repositories/meal_plan_repository.dart';
import '../datasources/meal_plan_data_source.dart';

class PlanRepositoryImpl implements PlanRepository {
  final PlanRemoteDataSource remoteDataSource;

  PlanRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MealPlanCreateEntity>> addBulkMealPlan(List<MealPlanCreateEntity> mealPlans) async {
    try {
      final response = await remoteDataSource.addBulkMealPlan(
        mealPlans.map((e) => e.toModel()).toList(),
      );
      return response.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Error in addBulkMealPlan: $e');
    }
  }

  @override
  Future<MealPlanCreateEntity> addMealPlan(MealPlanCreateEntity mealPlan) async {
    try {
      final response = await remoteDataSource.addMealPlan(mealPlan.toModel());
      return response.toEntity();
    } catch (e) {
      throw Exception('Error in addMealPlan: $e');
    }
  }

  @override
  Future<void> deleteMealPlan(int id) async {
    try {
      await remoteDataSource.deleteMealPlan(id);
    } catch (e) {
      throw Exception('Error in deleteMealPlan: $e');
    }
  }

  @override
  Future<List<MealPlanEntity>> getMealPlan(String date) async {
    try {
      final response = await remoteDataSource.getMealPlan(date);
      return response.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Error in getMealPlan: $e');
    }
  }
}
