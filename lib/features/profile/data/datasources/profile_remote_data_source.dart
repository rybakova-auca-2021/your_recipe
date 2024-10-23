import 'package:dio/dio.dart';
import 'package:your_recipe/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getMyProfile(int id);
  Future<void> updateProfile(ProfileModel profileModel, int id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProfileModel> getMyProfile(int id) async {
    final response = await dio.get(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/me/$id/',
    );

    if (response.statusCode == 200) {
      return ProfileModel.fromJson(response.data);
    } else {
      throw Exception('Fetching profile data failed');
    }
  }


  @override
  Future<void> updateProfile(ProfileModel profileModel, int id) async {
    final response = await dio.put(
      'https://ringtail-renewing-terminally.ngrok-free.app/chefmate/users/profile/update/$id/',
      data: profileModel.toJson(),
    );
    if (response.statusCode != 200) {
      throw Exception('updating profile failed');
    }
  }
}
