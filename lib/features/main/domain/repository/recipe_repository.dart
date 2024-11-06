import 'package:your_recipe/features/main/domain/entity/collection_entity.dart';
import 'package:your_recipe/features/main/domain/entity/favorite_entity.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_entity.dart';

import '../entity/recipe_detail_entity.dart';

abstract class RecipeRepository {
  Future<List<CollectionEntity>> fetchCollections();
  Future<List<RecipeDetailEntity>> filterRecipes(Map<String, dynamic> filters);
  Future<List<RecipeDetailEntity>> collectionsRecipes(int id);
  Future<List<PopularRecipeEntity>> fetchPopularRecipes(String period);
  Future<List<PopularRecipeEntity>> searchRecipes(String query);
  Future<RecipeDetailEntity> fetchRecipeById(int id);
  Future<FavoriteEntity> saveRecipe(int id);
  Future<List<PopularRecipeEntity>> fetchFavoriteRecipes();
}
