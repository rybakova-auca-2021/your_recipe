import '../entities/preference_domain.dart';
import '../repositories/preference_repository.dart';

class GetPreferredFoodUseCase {
  final PreferenceRepository repository;

  GetPreferredFoodUseCase({required this.repository});

  Future<List<PreferenceDomain>> execute() async {
    return await repository.getPreferredFood();
  }
}
