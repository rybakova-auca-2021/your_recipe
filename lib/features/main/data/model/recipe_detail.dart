import '../../domain/entity/recipe_detail_entity.dart';

class RecipeDetail {
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

  RecipeDetail({
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

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDesc: json['short_desc'],
      time: json['time'],
      difficulty: json['difficulty'],
      numberOfPeople: json['number_of_people'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      imageUrl: json['image_url'],
      isFavorite: json['is_favorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'short_desc': shortDesc,
      'time': time,
      'difficulty': difficulty,
      'number_of_people': numberOfPeople,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'ingredients': ingredients,
      'steps': steps,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
    };
  }

  RecipeDetailEntity toEntity() {
    return RecipeDetailEntity(
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
      isFavorite: isFavorite
    );
  }
}
