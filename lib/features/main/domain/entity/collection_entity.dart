import 'package:your_recipe/features/main/domain/entity/recipe_entity.dart';

class CollectionEntity {
  final int id;
  final String title;
  final String imageUrl;
  final List<PopularRecipeEntity> recipes;

  CollectionEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.recipes,
  });
}
