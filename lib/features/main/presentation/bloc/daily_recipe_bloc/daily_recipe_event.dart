part of 'daily_recipe_bloc.dart';

abstract class RecipeOfTheDayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRecipeOfTheDayEvent extends RecipeOfTheDayEvent {}
