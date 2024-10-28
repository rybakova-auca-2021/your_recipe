import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class AddGroceryUsecase implements UseCase<GroceryItemResponseEntity, GroceryItemEntity> {
  final GroceryRepository repository;

  AddGroceryUsecase(this.repository);

  @override
  Future<GroceryItemResponseEntity> call(GroceryItemEntity groceryItem) async {
    return await repository.addGrocery(groceryItem);
  }
}
