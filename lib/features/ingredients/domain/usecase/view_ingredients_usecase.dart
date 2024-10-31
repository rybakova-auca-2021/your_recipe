import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class ViewIngredientsUseCase implements UseCase<List<Ingredient>, String> {
  final IngredientRepository repository;

  ViewIngredientsUseCase(this.repository);

  @override
  Future<List<Ingredient>> call(String category) async {
    final ingredients = await repository.viewGroceries(category);
    print('Fetched ingredients: $ingredients');
    return ingredients;
  }
}
