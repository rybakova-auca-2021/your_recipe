import 'package:your_recipe/features/preferences/data/datasources/preference_remote_data_source.dart';
import 'package:your_recipe/features/preferences/domain/entities/preference_domain.dart';
import 'package:your_recipe/features/preferences/domain/repositories/preference_repository.dart';

class PreferenceRepositoryImpl implements PreferenceRepository {
  final PreferenceRemoteDataSource remoteDataSource;

  PreferenceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<int>> addPreferredCuisine(List<int> cuisineIds) async {
    final response = await remoteDataSource.addPreferredCuisine(cuisineIds);
    return response;
  }

  @override
  Future<List<int>> addPreferredFood(List<int> foodIds) async {
    final response = await remoteDataSource.addPreferredFood(foodIds);
    return response;
  }

  @override
  Future<List<PreferenceDomain>> fetchCuisine() async {
    final cuisineModels = await remoteDataSource.fetchCuisine();
    return cuisineModels
        .map((model) => PreferenceDomain(id: model.id, name: model.name))
        .toList();
  }

  @override
  Future<List<PreferenceDomain>> fetchFood() async {
    final foodModels = await remoteDataSource.fetchFood();
    return foodModels
        .map((model) => PreferenceDomain(id: model.id, name: model.name))
        .toList();
  }

  @override
  Future<List<PreferenceDomain>> getPreferredCuisine() async {
    final cuisineModels = await remoteDataSource.getPreferredCuisine();
    return cuisineModels
        .map((model) => PreferenceDomain(id: model.id, name: model.name))
        .toList();
  }

  @override
  Future<List<PreferenceDomain>> getPreferredFood() async {
    final foodModels = await remoteDataSource.getPreferredFood();
    return foodModels
        .map((model) => PreferenceDomain(id: model.id, name: model.name))
        .toList();
  }
}
