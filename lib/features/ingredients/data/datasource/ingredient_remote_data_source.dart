import 'package:dio/dio.dart';
import 'package:your_recipe/features/grocery/data/model/grocery_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/ingredients/data/model/ingredient_request.dart';
import 'package:your_recipe/features/ingredients/data/model/ingredient_response.dart';

abstract class IngredientRemoteDataSource {
  Future<IngredientResponse> addIngredient(IngredientRequest ingredientItem);
  Future<IngredientResponse> editIngredient(int id, IngredientRequest ingredientItem);
  Future<List<IngredientResponse>> viewIngredients(String category);
  Future<void> deleteIngredient(int id);
  Future<void> deleteAll();
}

class IngredientRemoteDataSourceImpl implements IngredientRemoteDataSource {
  final Dio dio;

  IngredientRemoteDataSourceImpl({required this.dio});

  Future<String?> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  @override
  Future<IngredientResponse> addIngredient(IngredientRequest ingredientItem) async {
    final accessToken = await _getAccessToken();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/ingredients/add/',
      data: ingredientItem.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 201) {
      return IngredientResponse.fromJson(response.data);
    } else {
      throw Exception('Adding ingredient failed');
    }
  }

  @override
  Future<void> deleteAll() async {
    final accessToken = await _getAccessToken();

    final response = await dio.delete(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/ingredients/delete_all/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 204) {
      throw Exception('Deleting all ingredients failed');
    }
  }

  @override
  Future<void> deleteIngredient(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.delete(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/ingredients/delete/$id/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 204) {
      throw Exception('Deleting ingredient failed');
    }
  }

  @override
  Future<IngredientResponse> editIngredient(int id, IngredientRequest ingredientItem) async {
    final accessToken = await _getAccessToken();

    final response = await dio.put(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/ingredients/edit/$id/',
      data: ingredientItem.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return IngredientResponse.fromJson(response.data);
    } else {
      throw Exception('Editing ingredient failed');
    }
  }

  @override
  Future<List<IngredientResponse>> viewIngredients(String category) async {
    final accessToken = await _getAccessToken();

    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/ingredients/view/?category=${category}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((item) => IngredientResponse.fromJson(item)).toList();
    } else {
      throw Exception('Fetching ingredients failed');
    }
  }
}
