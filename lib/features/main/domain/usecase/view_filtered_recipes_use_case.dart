import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';
import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class ViewFilteredRecipesUseCase implements UseCase<List<RecipeDetailEntity>, Map<String, dynamic>> {
  final RecipeRepository repository;

  ViewFilteredRecipesUseCase(this.repository);

  @override
  Future<List<RecipeDetailEntity>> call(Map<String, dynamic> filters) async {
    final recipes = await repository.filterRecipes(filters);
    return recipes;
  }
}