import '../../../main/data/model/recipe_detail.dart';

class MealPlan {
  final int id;
  final String date;
  final String mealType;
  final RecipeDetail recipe;

  MealPlan({
    required this.id,
    required this.date,
    required this.mealType,
    required this.recipe,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'],
      date: json['date'],
      mealType: json['meal_type'],
      recipe: RecipeDetail.fromJson(json['recipe']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'meal_type': mealType,
      'recipe': recipe.toJson(),
    };
  }

  static List<MealPlan> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MealPlan.fromJson(json)).toList();
  }
}
