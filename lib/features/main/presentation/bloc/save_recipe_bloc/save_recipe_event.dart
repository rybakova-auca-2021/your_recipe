part of 'save_recipe_bloc.dart';

abstract class RecipeFavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveRecipeEvent extends RecipeFavoriteEvent {
  final int recipeId;

  SaveRecipeEvent(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}
