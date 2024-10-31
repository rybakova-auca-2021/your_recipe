import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class DeleteAllIngredientsUseCase implements UseCase<void, void> {
  final IngredientRepository repository;

  DeleteAllIngredientsUseCase(this.repository);

  @override
  Future<void> call(void params) async {
    await repository.deleteAll();
  }
}
