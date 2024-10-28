import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class DeleteGroceryUsecase implements UseCase<void, int> {
  final GroceryRepository repository;

  DeleteGroceryUsecase(this.repository);

  @override
  Future<void> call(int id) async {
    await repository.deleteGrocery(id);
  }
}
