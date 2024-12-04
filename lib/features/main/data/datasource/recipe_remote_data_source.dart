import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/main/data/model/collection.dart';
import 'package:your_recipe/features/main/data/model/favorite_recipe.dart';
import 'package:your_recipe/features/main/data/model/recipe.dart';
import 'package:your_recipe/features/main/data/model/recipe_detail.dart';

abstract class RecipeRemoteDataSource {
  Future<List<Collection>> fetchCollections();
  Future<List<RecipeDetail>> filterRecipes(Map<String, dynamic> filters);
  Future<List<PopularRecipe>> fetchPopularRecipes(String period);
  Future<List<PopularRecipe>> searchRecipes(String query);
  Future<RecipeDetail> fetchRecipeById(int id);
  Future<List<RecipeDetail>> collectionRecipes(int id);
  Future<FavoriteRecipe> saveRecipe(int id);
  Future<List<PopularRecipe>> fetchFavoriteRecipes();
  Future<PopularRecipe> fetchRecipeOfTheDay();
  Future<List<RecipeDetail>> recipesByCategory(String category);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final Dio dio;

  RecipeRemoteDataSourceImpl({required this.dio});

  Future<String?> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  @override
  Future<List<Collection>> fetchCollections() async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/collections/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => Collection.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch recipe collections');
    }
  }

  @override
  Future<List<RecipeDetail>> filterRecipes(Map<String, dynamic> filters) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/filter/',
      queryParameters: filters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => RecipeDetail.fromJson(item)).toList();
    } else {
      throw Exception('Failed to filter recipes');
    }
  }

  @override
  Future<List<PopularRecipe>> fetchPopularRecipes(String period) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/popular/$period/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => PopularRecipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch popular recipes');
    }
  }

  @override
  Future<List<PopularRecipe>> searchRecipes(String query) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/search/',
      queryParameters: {'search': query},
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => PopularRecipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  @override
  Future<RecipeDetail> fetchRecipeById(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/$id/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return RecipeDetail.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch recipe by ID');
    }
  }

  @override
  Future<List<RecipeDetail>> collectionRecipes(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/collection/$id/recipes/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => RecipeDetail.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch collection\'s recipes');
    }
  }

  @override
  Future<FavoriteRecipe> saveRecipe(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/$id/favorite/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return FavoriteRecipe.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch collection\'s recipes');
    }
  }

  @override
  Future<List<PopularRecipe>> fetchFavoriteRecipes() async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/favorites/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => PopularRecipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch favorite recipes');
    }
  }

  @override
  Future<PopularRecipe> fetchRecipeOfTheDay() async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipe-of-the-day/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return PopularRecipe.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch recipe of the day');
    }
  }

  @override
  Future<List<RecipeDetail>> recipesByCategory(String category) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/recipe/recipes/category/$category/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => RecipeDetail.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch recipes by categories');
    }
  }
}
