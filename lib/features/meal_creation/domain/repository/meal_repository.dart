import '../cubit/meal/meal_cubit.dart';

abstract class AbstractMealRepository {
  Future<List<String>> getMeals(MealSettingsParameters parameters);
}
