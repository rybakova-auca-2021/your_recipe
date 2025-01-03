import 'package:dio/dio.dart';
import 'package:your_recipe/features/grocery/data/model/grocery_item_model.dart';
import 'package:your_recipe/features/grocery/data/model/grocery_item_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GroceryRemoteDataSource {
  Future<GroceryItemResponse> addGrocery(GroceryItemModel groceryItem);
  Future<List<GroceryItemResponse>> addGroceries(List<GroceryItemModel> groceryItems);
  Future<GroceryItemResponse> editGrocery(int id, GroceryItemModel groceryItem);
  Future<List<GroceryItemResponse>> viewGroceries();
  Future<void> deleteGrocery(int id);
  Future<void> deleteAll();
  Future<void> markPurchased(int id);
}

class GroceryRemoteDataSourceImpl implements GroceryRemoteDataSource {
  final Dio dio;

  GroceryRemoteDataSourceImpl({required this.dio});

  Future<String?> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  @override
  Future<GroceryItemResponse> addGrocery(GroceryItemModel groceryItem) async {
    final accessToken = await _getAccessToken();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/add/',
      data: groceryItem.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 201) {
      return GroceryItemResponse.fromJson(response.data);
    } else {
      throw Exception('Adding grocery failed');
    }
  }

  @override
  Future<List<GroceryItemResponse>> addGroceries(List<GroceryItemModel> groceryItems) async {
    final accessToken = await _getAccessToken();

    final List<Map<String, dynamic>> jsonItems = groceryItems.map((item) => item.toJson()).toList();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/add/groceries/',
      data: jsonItems,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 201) {
      return (response.data as List)
          .map((item) => GroceryItemResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Adding groceries failed');
    }
  }

  @override
  Future<void> deleteAll() async {
    final accessToken = await _getAccessToken();

    final response = await dio.delete(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/delete_all/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 204) {
      throw Exception('Deleting all groceries failed');
    }
  }

  @override
  Future<void> deleteGrocery(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.delete(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/delete/$id/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 204) {
      throw Exception('Deleting grocery failed');
    }
  }

  @override
  Future<GroceryItemResponse> editGrocery(int id, GroceryItemModel groceryItem) async {
    final accessToken = await _getAccessToken();

    final response = await dio.put(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/edit/$id/',
      data: groceryItem.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      return GroceryItemResponse.fromJson(response.data);
    } else {
      throw Exception('Editing grocery failed');
    }
  }

  @override
  Future<List<GroceryItemResponse>> viewGroceries() async {
    final accessToken = await _getAccessToken();

    print("access token $accessToken");
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/view/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print('Fetched data: $data');
      return data.map((item) => GroceryItemResponse.fromJson(item)).toList();
    } else {
      throw Exception('Fetching groceries failed');
    }
  }

  @override
  Future<void> markPurchased(int id) async {
    final accessToken = await _getAccessToken();

    final response = await dio.post(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/grocery/mark-purchased/$id/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark grocery as purchased');
    }
  }
}
