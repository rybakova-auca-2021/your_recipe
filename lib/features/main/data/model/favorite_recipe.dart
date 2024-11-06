import 'package:your_recipe/features/main/domain/entity/favorite_entity.dart';

class FavoriteRecipe {
  final int id;
  final int user;
  final int recipe;
  final String createdAt;

  FavoriteRecipe({
    required this.id,
    required this.user,
    required this.recipe,
    required this.createdAt,
  });

  factory FavoriteRecipe.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipe(
      id: json['id'],
      user: json['user'],
      recipe: json['recipe'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'recipe': recipe,
      'created_at': createdAt,
    };
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
        id: id,
        user: user,
        recipe: recipe,
        createdAt: createdAt,
    );
  }
}
