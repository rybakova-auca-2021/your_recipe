import '../../../auth/domain/usecases/usecase.dart';
import '../repository/grocery_repository.dart';

class MarkPurchasedUsecase implements UseCase<void, int> {
  final GroceryRepository repository;

  MarkPurchasedUsecase(this.repository);

  @override
  Future<void> call(int id) async {
    await repository.markPurchased(id);
  }
}
