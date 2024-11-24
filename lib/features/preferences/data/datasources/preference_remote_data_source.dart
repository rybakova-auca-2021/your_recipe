import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/preferences/data/models/cuisine_model.dart';
import 'package:your_recipe/features/preferences/data/models/food_model.dart';

abstract class PreferenceRemoteDataSource {
  Future<List<int>> addPreferredCuisine(List<int> cuisineIds);
  Future<List<CuisineModel>> getPreferredCuisine();
  Future<List<CuisineModel>> fetchCuisine();

  Future<List<int>> addPreferredFood(List<int> foodIds);
  Future<List<FoodModel>> getPreferredFood();
  Future<List<FoodModel>> fetchFood();
}

class PreferenceRemoteDataSourceImpl implements PreferenceRemoteDataSource {
  final Dio dio;

  PreferenceRemoteDataSourceImpl({required this.dio});

  Future<String?> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  @override
  Future<List<int>> addPreferredCuisine(List<int> cuisineIds) async {
    final accessToken = await _getAccessToken();

    print("access token $accessToken");

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/cuisines/add-preferred/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: jsonEncode(cuisineIds),
    );

    if (response.statusCode != 200) {
      throw Exception('Adding preferred cuisines failed');
    }

    return cuisineIds;
  }

  @override
  Future<List<int>> addPreferredFood(List<int> foodIds) async {
    final accessToken = await _getAccessToken();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/food/add-preferred/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: jsonEncode(foodIds),
    );

    if (response.statusCode != 200) {
      throw Exception('Adding preferred foods failed');
    }

    return foodIds;
  }

  @override
  Future<List<CuisineModel>> fetchCuisine() async {
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/fetch-cuisines/',
    );

    if (response.statusCode != 200) {
      throw Exception('Fetching cuisines failed');
    }

    final data = response.data as List;
    return data.map((json) => CuisineModel.fromJson(json)).toList();
  }

  @override
  Future<List<FoodModel>> fetchFood() async {
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/fetch-food/',
    );

    if (response.statusCode != 200) {
      throw Exception('Fetching foods failed');
    }

    final data = response.data as List;
    return data.map((json) => FoodModel.fromJson(json)).toList();
  }

  @override
  Future<List<CuisineModel>> getPreferredCuisine() async {
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/cuisines/preferred/',
    );

    if (response.statusCode != 200) {
      throw Exception('Getting preferred cuisines failed');
    }

    final data = response.data as List;
    return data.map((json) => CuisineModel.fromJson(json)).toList();
  }

  @override
  Future<List<FoodModel>> getPreferredFood() async {
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/preferences/food/preferred/',
    );

    if (response.statusCode != 200) {
      throw Exception('Getting preferred foods failed');
    }

    final data = response.data as List;
    return data.map((json) => FoodModel.fromJson(json)).toList();
  }
}
