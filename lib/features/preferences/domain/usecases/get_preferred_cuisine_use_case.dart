import '../entities/preference_domain.dart';
import '../repositories/preference_repository.dart';

class GetPreferredCuisineUseCase {
  final PreferenceRepository repository;

  GetPreferredCuisineUseCase({required this.repository});

  Future<List<PreferenceDomain>> execute() async {
    return await repository.getPreferredCuisine();
  }
}
