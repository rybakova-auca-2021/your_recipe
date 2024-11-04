part of 'popular_recipes_bloc.dart';

abstract class PopularRecipesState extends Equatable {
  const PopularRecipesState();

  @override
  List<Object> get props => [];
}

class PopularRecipesInitial extends PopularRecipesState {}

class PopularRecipesLoading extends PopularRecipesState {}

class PopularRecipesLoaded extends PopularRecipesState {
  final List<PopularRecipeEntity> recipes;

  const PopularRecipesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class PopularRecipesError extends PopularRecipesState {
  final String message;

  const PopularRecipesError(this.message);

  @override
  List<Object> get props => [message];
}