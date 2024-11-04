import '../../../auth/domain/usecases/usecase.dart';
import '../entity/recipe_detail_entity.dart';
import '../repository/recipe_repository.dart';

class ViewRecipesInCollectionUseCase implements UseCase<List<RecipeDetailEntity>, int> {
  final RecipeRepository repository;

  ViewRecipesInCollectionUseCase(this.repository);

  @override
  Future<List<RecipeDetailEntity>> call(int id) async {
    final recipes = await repository.collectionsRecipes(id);
    return recipes;
  }
}