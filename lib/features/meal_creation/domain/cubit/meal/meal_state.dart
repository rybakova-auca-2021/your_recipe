part of 'meal_cubit.dart';

@immutable
sealed class MealState {}

final class MealSettingsParameters extends MealState {
  final int people;
  final int maxTimeCooking;
  final String? intoleranceOrLimits;
  final String? ingredients;
  final XFile? picture;
  final String type;

  MealSettingsParameters({
    required this.people,
    required this.maxTimeCooking,
    required this.intoleranceOrLimits,
    required this.ingredients,
    required this.picture,
    required this.type
  });

  MealSettingsParameters copyWith({
    int? people,
    int? maxTimeCooking,
    String? intoleranceOrLimits,
    String? ingredients,
    XFile? picture,
    String? type,
  }) =>
      MealSettingsParameters(
        people: people ?? this.people,
        maxTimeCooking: maxTimeCooking ?? this.maxTimeCooking,
        intoleranceOrLimits: intoleranceOrLimits ?? this.intoleranceOrLimits,
        ingredients: ingredients ?? this.ingredients,
        picture: picture ?? this.picture,
        type: type ?? this.type
      );

  bool isReadyToGenerate() => true;

  @override
  String toString() {
    return 'MealSettingsParameters(people: $people, maxTimeCooking: $maxTimeCooking, intoleranceOrLimits: $intoleranceOrLimits, picture: $picture, ingredients: $ingredients)';
  }
}

final class MealLoading extends MealState {}

final class MealLoaded extends MealState {
  final List<String> meals;

  MealLoaded({required this.meals});

  @override
  String toString() => 'MealLoaded(meals: $meals)';
}

final class ErrorState extends MealState {
  final dynamic error;

  ErrorState(this.error);

  @override
  String toString() => 'MealError(message: $error)';
}
