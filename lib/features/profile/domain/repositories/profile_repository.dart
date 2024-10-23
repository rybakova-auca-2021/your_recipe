import 'package:your_recipe/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> fetchProfile(int id);
  Future<void> updateProfile(ProfileEntity profileEntity);
}
