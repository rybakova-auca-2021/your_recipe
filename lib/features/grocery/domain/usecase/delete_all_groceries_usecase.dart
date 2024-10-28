import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class DeleteAllGroceriesUsecase implements UseCase<void, void> {
  final GroceryRepository repository;

  DeleteAllGroceriesUsecase(this.repository);

  @override
  Future<void> call(void params) async {
    await repository.deleteAll();
  }
}
