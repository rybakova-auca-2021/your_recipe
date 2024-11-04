import 'package:your_recipe/features/main/domain/entity/collection_entity.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../repository/recipe_repository.dart';

class ViewCollectionsUseCase implements UseCase<List<CollectionEntity>, void> {
  final RecipeRepository repository;

  ViewCollectionsUseCase(this.repository);

  @override
  Future<List<CollectionEntity>> call(void params) async {
    final collections = await repository.fetchCollections();
    return collections;
  }
}