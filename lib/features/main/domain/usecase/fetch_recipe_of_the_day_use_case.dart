import 'package:your_recipe/features/main/domain/entity/recipe_entity.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../repository/recipe_repository.dart';

class FetchRecipeOfTheDayUseCase implements UseCase<PopularRecipeEntity, void> {
  final RecipeRepository repository;

  FetchRecipeOfTheDayUseCase(this.repository);

  @override
  Future<PopularRecipeEntity> call(void params) async {
    final recipe = await repository.fetchRecipeOfTheDay();
    return recipe;
  }
}