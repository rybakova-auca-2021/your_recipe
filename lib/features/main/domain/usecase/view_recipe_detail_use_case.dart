import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';
import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';

import '../../../auth/domain/usecases/usecase.dart';

class ViewRecipeDetailUseCase implements UseCase<RecipeDetailEntity, int> {
  final RecipeRepository repository;

  ViewRecipeDetailUseCase(this.repository);

  @override
  Future<RecipeDetailEntity> call(int id) async {
    final recipeDetail = await repository.fetchRecipeById(id);
    return recipeDetail;
  }
}