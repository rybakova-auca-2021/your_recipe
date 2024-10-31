import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';

abstract class IngredientRepository {
  Future<Ingredient> addGrocery(Ingredient ingredient);
  Future<Ingredient> editGrocery(int id, Ingredient ingredient);
  Future<List<Ingredient>> viewGroceries(String category);
  Future<void> deleteGrocery(int id);
  Future<void> deleteAll();
}