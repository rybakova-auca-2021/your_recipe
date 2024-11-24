import '../repositories/preference_repository.dart';

class AddPreferredCuisineUseCase {
  final PreferenceRepository repository;

  AddPreferredCuisineUseCase({required this.repository});

  Future<List<int>> execute(List<int> cuisineIds) async {
    return await repository.addPreferredCuisine(cuisineIds);
  }
}
