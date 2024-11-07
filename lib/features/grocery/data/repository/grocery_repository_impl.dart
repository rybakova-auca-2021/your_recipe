import 'package:your_recipe/features/grocery/data/datasources/grocery_remote_data_source.dart';
import 'package:your_recipe/features/grocery/data/model/grocery_item_model.dart';
import '../../domain/entities/grocery_item_entity.dart';
import '../../domain/entities/grocery_item_response_entity.dart';
import '../../domain/repository/grocery_repository.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  final GroceryRemoteDataSource remoteDataSource;

  GroceryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<GroceryItemResponseEntity> addGrocery(GroceryItemEntity groceryItem) async {
    final groceryItemModel = GroceryItemModel(
      name: groceryItem.name,
      quantity: groceryItem.quantity,
    );
    final response = await remoteDataSource.addGrocery(groceryItemModel);

    return GroceryItemResponseEntity(
      id: response.id,
      user: response.user,
      name: response.name,
      quantity: response.quantity,
    );
  }

  @override
  Future<List<GroceryItemResponseEntity>> addGroceries(List<GroceryItemEntity> groceryItems) async {
    final groceryItemModels = groceryItems.map((item) => GroceryItemModel(
      name: item.name,
      quantity: item.quantity,
    )).toList();

    final responseList = await remoteDataSource.addGroceries(groceryItemModels);

    return responseList.map((response) => GroceryItemResponseEntity(
      id: response.id,
      user: response.user,
      name: response.name,
      quantity: response.quantity,
    )).toList();
  }

  @override
  Future<void> deleteAll() async {
    await remoteDataSource.deleteAll();
  }

  @override
  Future<void> deleteGrocery(int id) async {
    await remoteDataSource.deleteGrocery(id);
  }

  @override
  Future<GroceryItemResponseEntity> editGrocery(int id, GroceryItemEntity groceryItem) async {
    final groceryItemModel = GroceryItemModel(
      name: groceryItem.name,
      quantity: groceryItem.quantity,
    );
    final response = await remoteDataSource.editGrocery(id, groceryItemModel);

    return GroceryItemResponseEntity(
      id: response.id,
      name: response.name,
      quantity: response.quantity,
      user: response.user
    );
  }

  @override
  Future<List<GroceryItemResponseEntity>> viewGroceries() async {
    final groceryItemResponses = await remoteDataSource.viewGroceries();
    return groceryItemResponses.map((response) {
      return GroceryItemResponseEntity(
        id: response.id,
        name: response.name,
        quantity: response.quantity,
        user: response.user,
      );
    }).toList();
  }
}
