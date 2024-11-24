import '../repositories/preference_repository.dart';

class AddPreferredFoodUseCase {
  final PreferenceRepository repository;

  AddPreferredFoodUseCase({required this.repository});

  Future<List<int>> execute(List<int> foodIds) async {
    return await repository.addPreferredFood(foodIds);
  }
}

