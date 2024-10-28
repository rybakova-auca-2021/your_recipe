import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class ViewGroceriesUsecase implements UseCase<List<GroceryItemResponseEntity>, void> {
  final GroceryRepository repository;

  ViewGroceriesUsecase(this.repository);

  @override
  Future<List<GroceryItemResponseEntity>> call(void params) async {
    return await repository.viewGroceries();
  }
}
