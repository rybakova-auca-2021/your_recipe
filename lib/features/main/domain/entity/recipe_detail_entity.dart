import '../../data/model/recipe_detail.dart';

class RecipeDetailEntity {
  final int id;
  final String name;
  final String description;
  final String shortDesc;
  final String time;
  final String difficulty;
  final String numberOfPeople;
  final double protein;
  final double carbs;
  final double fat;
  final String ingredients;
  final String steps;
  final String imageUrl;
  final bool isFavorite;

  RecipeDetailEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDesc,
    required this.time,
    required this.difficulty,
    required this.numberOfPeople,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
    required this.isFavorite
  });
}

extension RecipeDetailMapper on RecipeDetailEntity {
  RecipeDetail toModel() {
    return RecipeDetail(
      id: id,
      name: name,
      description: description,
      shortDesc: shortDesc,
      time: time,
      difficulty: difficulty,
      numberOfPeople: numberOfPeople,
      protein: protein,
      carbs: carbs,
      fat: fat,
      ingredients: ingredients,
      steps: steps,
      imageUrl: imageUrl,
      isFavorite: isFavorite,
    );
  }
}
