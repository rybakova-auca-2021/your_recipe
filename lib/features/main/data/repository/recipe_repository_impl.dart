import 'package:your_recipe/features/main/domain/entity/collection_entity.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_entity.dart';

import '../../domain/repository/recipe_repository.dart';
import '../datasource/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CollectionEntity>> fetchCollections() async {
    final collections = await remoteDataSource.fetchCollections();
    return collections.map((collection) => collection.toEntity()).toList();
  }

  @override
  Future<List<RecipeDetailEntity>> filterRecipes(Map<String, dynamic> filters) async {
    final recipes = await remoteDataSource.filterRecipes(filters);
    return recipes.map((recipe) => recipe.toEntity()).toList();
  }

  @override
  Future<List<PopularRecipeEntity>> fetchPopularRecipes(String period) async {
    final recipes = await remoteDataSource.fetchPopularRecipes(period);
    return recipes.map((recipe) => recipe.toEntity()).toList();
  }

  @override
  Future<List<PopularRecipeEntity>> searchRecipes(String query) async {
    final recipes = await remoteDataSource.searchRecipes(query);
    return recipes.map((recipe) => recipe.toEntity()).toList();
  }

  @override
  Future<RecipeDetailEntity> fetchRecipeById(int id) async {
    final recipe = await remoteDataSource.fetchRecipeById(id);
    return recipe.toEntity();
  }

  @override
  Future<List<RecipeDetailEntity>> collectionsRecipes(int id) async {
    final recipes = await remoteDataSource.collectionRecipes(id);
    return recipes.map((recipe) => recipe.toEntity()).toList();
  }
}
