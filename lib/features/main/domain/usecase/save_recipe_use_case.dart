import 'package:your_recipe/features/main/domain/entity/favorite_entity.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../repository/recipe_repository.dart';

class SaveRecipeUseCase implements UseCase<FavoriteEntity, int> {
  final RecipeRepository repository;

  SaveRecipeUseCase(this.repository);

  @override
  Future<FavoriteEntity> call(int id) async {
    final recipe = await repository.saveRecipe(id);
    return recipe;
  }
}