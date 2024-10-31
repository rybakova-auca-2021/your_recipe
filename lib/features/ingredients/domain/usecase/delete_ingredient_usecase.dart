import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class DeleteIngredientUseCase implements UseCase<void, int> {
  final IngredientRepository repository;

  DeleteIngredientUseCase(this.repository);

  @override
  Future<void> call(int id) async {
    await repository.deleteGrocery(id);
  }
}
