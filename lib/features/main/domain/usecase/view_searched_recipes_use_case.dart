import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../entity/recipe_entity.dart';

class ViewSearchedRecipesUseCase implements UseCase<List<PopularRecipeEntity>, String> {
  final RecipeRepository repository;

  ViewSearchedRecipesUseCase(this.repository);

  @override
  Future<List<PopularRecipeEntity>> call(String searchQuery) async {
    final recipes = await repository.searchRecipes(searchQuery);
    return recipes;
  }
}