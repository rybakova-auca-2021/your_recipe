import 'package:your_recipe/features/main/data/model/recipe.dart';

import '../../domain/entity/collection_entity.dart';

class Collection {
  final int id;
  final String title;
  final String imageUrl;
  final List<PopularRecipe> recipes;

  Collection({
    required this.id,
    required this.title,
    required this.recipes,
    required this.imageUrl
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    var recipesList = json['recipes'] as List;
    List<PopularRecipe> recipes = recipesList.map((i) => PopularRecipe.fromJson(i)).toList();

    return Collection(
      id: json['id'],
      title: json['title'],
      recipes: recipes,
      imageUrl: json['image_url']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      recipes: recipes.map((recipe) => recipe.toEntity()).toList(),
    );
  }
}
