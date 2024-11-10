part of 'daily_recipe_bloc.dart';

abstract class RecipeOfTheDayState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeOfTheDayInitial extends RecipeOfTheDayState {}

class RecipeOfTheDayLoading extends RecipeOfTheDayState {}

class RecipeOfTheDayLoaded extends RecipeOfTheDayState {
  final PopularRecipeEntity recipe;

  RecipeOfTheDayLoaded(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class RecipeOfTheDayError extends RecipeOfTheDayState {
  final String message;

  RecipeOfTheDayError(this.message);

  @override
  List<Object> get props => [message];
}
