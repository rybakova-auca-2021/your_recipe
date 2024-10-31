import 'package:your_recipe/features/ingredients/data/datasource/ingredient_remote_data_source.dart';
import 'package:your_recipe/features/ingredients/data/model/ingredient_request.dart';
import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientRemoteDataSource remoteDataSource;

  IngredientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Ingredient> addGrocery(Ingredient ingredientItem) async {
    final ingredient = IngredientRequest(
      name: ingredientItem.name,
      quantity: ingredientItem.quantity,
      category: ingredientItem.category,
      manufactureDate: ingredientItem.manufactureDate,
      expirationDate: ingredientItem.expirationDate
    );
    final response = await remoteDataSource.addIngredient(ingredient);

    return Ingredient(
      id: response.id,
      user: response.user,
      name: response.name,
      quantity: response.quantity.toString(),
      manufactureDate: response.manufactureDate,
      expirationDate: response.expirationDate,
      category: response.category,
    );
  }

  @override
  Future<void> deleteAll() async {
    await remoteDataSource.deleteAll();
  }

  @override
  Future<void> deleteGrocery(int id) async {
    await remoteDataSource.deleteIngredient(id);
  }

  @override
  Future<Ingredient> editGrocery(int id, Ingredient ingredientItem) async {
    final ingredient = IngredientRequest(
        name: ingredientItem.name,
        quantity: ingredientItem.quantity,
        category: ingredientItem.category,
        manufactureDate: ingredientItem.manufactureDate,
        expirationDate: ingredientItem.expirationDate
    );
    final response = await remoteDataSource.editIngredient(id, ingredient);

    return Ingredient(
      id: response.id,
      user: response.user,
      name: response.name,
      quantity: response.quantity.toString(),
      manufactureDate: response.manufactureDate,
      expirationDate: response.expirationDate,
      category: response.category,
    );
  }

  @override
  Future<List<Ingredient>> viewGroceries(String category) async {
    print('Category received: $category');
    try {
      final groceryItemResponses = await remoteDataSource.viewIngredients(category);
      print('API response: $groceryItemResponses');
      return groceryItemResponses.map((response) {
        return Ingredient(
          id: response.id,
          user: response.user,
          name: response.name,
          quantity: response.quantity.toString(),
          manufactureDate: response.manufactureDate,
          expirationDate: response.expirationDate,
          category: response.category,
        );
      }).toList();
    } catch (e) {
      print('Error fetching groceries: $e');
      return [];
    }
  }
}
