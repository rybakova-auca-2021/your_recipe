import 'package:your_recipe/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:your_recipe/features/profile/data/model/profile_model.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity> fetchProfile(int id) async {
    final profileModel = await remoteDataSource.getMyProfile(id);

    return ProfileEntity(
      id: id,
      email: profileModel.email,
      username: profileModel.username,
      profilePhoto: profileModel.profilePhoto,
    );
  }

  @override
  Future<void> updateProfile(ProfileEntity profileEntity) async {
    final profileModel = ProfileModel(
        email: profileEntity.email,
        username: profileEntity.username,
        profilePhoto: profileEntity.profilePhoto
    );
    await remoteDataSource.updateProfile(profileModel, profileEntity.id);
  }
}
