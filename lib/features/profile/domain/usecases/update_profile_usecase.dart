import 'package:your_recipe/features/profile/domain/entities/profile_entity.dart';
import 'package:your_recipe/features/profile/domain/repositories/profile_repository.dart';
import '../../../auth/domain/usecases/usecase.dart';

class UpdateProfileUseCase implements UseCase<void, ProfileEntity> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<void> call(ProfileEntity entity) async {
    await repository.updateProfile(entity);
  }
}
