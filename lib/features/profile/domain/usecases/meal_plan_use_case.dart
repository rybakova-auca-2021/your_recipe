import '../entities/meal_plan_create_entity.dart';
import '../entities/meal_plan_entity.dart';
import '../repositories/meal_plan_repository.dart';

class AddBulkMealPlans {
  final PlanRepository repository;

  AddBulkMealPlans(this.repository);

  Future<List<MealPlanCreateEntity>> call(List<MealPlanCreateEntity> mealPlans) {
    return repository.addBulkMealPlan(mealPlans);
  }
}

class AddMealPlan {
  final PlanRepository repository;

  AddMealPlan(this.repository);

  Future<MealPlanCreateEntity> call(MealPlanCreateEntity mealPlan) {
    return repository.addMealPlan(mealPlan);
  }
}

class DeleteMealPlan {
  final PlanRepository repository;

  DeleteMealPlan(this.repository);

  Future<void> call(int id) {
    return repository.deleteMealPlan(id);
  }
}

class GetMealPlan {
  final PlanRepository repository;

  GetMealPlan(this.repository);

  Future<List<MealPlanEntity>> call(String date) {
    return repository.getMealPlan(date);
  }
}
