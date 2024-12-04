import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../repository/recipe_repository.dart';

class FetchRecipesByCategoryUseCase implements UseCase<List<RecipeDetailEntity>, String> {
  final RecipeRepository repository;

  FetchRecipesByCategoryUseCase(this.repository);

  @override
  Future<List<RecipeDetailEntity>> call(String category) async {
    final recipes = await repository.recipesByCategory(category);
    return recipes;
  }
}