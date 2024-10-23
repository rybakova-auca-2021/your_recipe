import 'package:your_recipe/features/profile/domain/entities/profile_entity.dart';
import 'package:your_recipe/features/profile/domain/repositories/profile_repository.dart';
import '../../../auth/domain/usecases/usecase.dart';

class FetchProfileUsecase implements UseCase<ProfileEntity, int> {
  final ProfileRepository repository;

  FetchProfileUsecase(this.repository);

  @override
  Future<ProfileEntity> call(int id) async {
    return await repository.fetchProfile(id);
  }
}
