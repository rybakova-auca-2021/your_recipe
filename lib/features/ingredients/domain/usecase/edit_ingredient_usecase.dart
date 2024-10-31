import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class EditIngredientUseCase implements UseCase<Ingredient, Map<String, dynamic>> {
  final IngredientRepository repository;

  EditIngredientUseCase(this.repository);

  @override
  Future<Ingredient> call(Map<String, dynamic> params) async {
    final id = params['id'] as int;
    final groceryItem = params['ingredientItem'] as Ingredient;
    return await repository.editGrocery(id, groceryItem);
  }
}

