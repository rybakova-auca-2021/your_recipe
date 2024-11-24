import '../entities/preference_domain.dart';
import '../repositories/preference_repository.dart';

class FetchFoodUseCase {
  final PreferenceRepository repository;

  FetchFoodUseCase({required this.repository});

  Future<List<PreferenceDomain>> execute() async {
    return await repository.fetchFood();
  }
}

