part of 'collection_recipe_bloc.dart';

abstract class CollectionRecipeState extends Equatable {
  const CollectionRecipeState();

  @override
  List<Object> get props => [];
}

class CollectionRecipesInitial extends CollectionRecipeState {}

class CollectionRecipesLoading extends CollectionRecipeState {}

class CollectionRecipesLoaded extends CollectionRecipeState {
  final List<RecipeDetailEntity> recipes;

  const CollectionRecipesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class CollectionRecipesError extends CollectionRecipeState {
  final String message;

  const CollectionRecipesError(this.message);

  @override
  List<Object> get props => [message];
}