import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../entity/recipe_entity.dart';

class ViewPopularUseCase implements UseCase<List<PopularRecipeEntity>, String> {
  final RecipeRepository repository;

  ViewPopularUseCase(this.repository);

  @override
  Future<List<PopularRecipeEntity>> call(String period) async {
    final recipes = await repository.fetchPopularRecipes(period);
    return recipes;
  }
}