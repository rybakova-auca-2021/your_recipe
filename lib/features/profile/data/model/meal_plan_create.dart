class MealPlanCreate {
  final String date;
  final String mealType;
  final int recipe;

  MealPlanCreate({
    required this.date,
    required this.mealType,
    required this.recipe,
  });

  factory MealPlanCreate.fromJson(Map<String, dynamic> json) {
    return MealPlanCreate(
      date: json['date'],
      mealType: json['meal_type'],
      recipe: json['recipe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'meal_type': mealType,
      'recipe': recipe,
    };
  }
}
