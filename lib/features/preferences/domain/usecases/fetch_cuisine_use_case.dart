import '../entities/preference_domain.dart';
import '../repositories/preference_repository.dart';

class FetchCuisineUseCase {
  final PreferenceRepository repository;

  FetchCuisineUseCase({required this.repository});

  Future<List<PreferenceDomain>> execute() async {
    return await repository.fetchCuisine();
  }
}
