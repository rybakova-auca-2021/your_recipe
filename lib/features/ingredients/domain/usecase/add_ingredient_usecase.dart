import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class AddIngredientUseCase implements UseCase<Ingredient, Ingredient> {
  final IngredientRepository repository;

  AddIngredientUseCase(this.repository);

  @override
  Future<Ingredient> call(Ingredient ingredient) async {
    return await repository.addGrocery(ingredient);
  }
}
