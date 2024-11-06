import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../entity/recipe_entity.dart';

class FetchFavoritesUseCase implements UseCase<List<PopularRecipeEntity>, void> {
  final RecipeRepository repository;

  FetchFavoritesUseCase(this.repository);

  @override
  Future<List<PopularRecipeEntity>> call(void params) async {
    final recipes = await repository.fetchFavoriteRecipes();
    return recipes;
  }
}