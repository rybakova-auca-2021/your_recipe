import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class AddGroceriesUseCase implements UseCase<List<GroceryItemResponseEntity>, List<GroceryItemEntity>> {
  final GroceryRepository repository;

  AddGroceriesUseCase(this.repository);

  @override
  Future<List<GroceryItemResponseEntity>> call(List<GroceryItemEntity> groceryItems) async {
    return await repository.addGroceries(groceryItems);
  }
}
