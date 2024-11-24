import 'package:your_recipe/features/preferences/domain/entities/preference_domain.dart';

abstract class PreferenceRepository {
  Future<List<int>> addPreferredCuisine(List<int> cuisineIds);
  Future<List<PreferenceDomain>> getPreferredCuisine();
  Future<List<PreferenceDomain>> fetchCuisine();

  Future<List<int>> addPreferredFood(List<int> foodIds);
  Future<List<PreferenceDomain>> getPreferredFood();
  Future<List<PreferenceDomain>> fetchFood();
}