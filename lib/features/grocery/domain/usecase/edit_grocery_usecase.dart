import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class EditGroceryUsecase implements UseCase<GroceryItemResponseEntity, Map<String, dynamic>> {
  final GroceryRepository repository;

  EditGroceryUsecase(this.repository);

  @override
  Future<GroceryItemResponseEntity> call(Map<String, dynamic> params) async {
    final id = params['id'] as int;
    final groceryItem = params['groceryItem'] as GroceryItemEntity;
    return await repository.editGrocery(id, groceryItem);
  }
}
