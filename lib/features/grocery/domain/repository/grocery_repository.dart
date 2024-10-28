
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';

abstract class GroceryRepository {
  Future<GroceryItemResponseEntity> addGrocery(GroceryItemEntity groceryItem);
  Future<GroceryItemResponseEntity> editGrocery(int id, GroceryItemEntity groceryItem);
  Future<List<GroceryItemResponseEntity>> viewGroceries();
  Future<void> deleteGrocery(int id);
  Future<void> deleteAll();
}