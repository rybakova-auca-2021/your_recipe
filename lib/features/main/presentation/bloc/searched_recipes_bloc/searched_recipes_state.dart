part of 'searched_recipes_bloc.dart';

abstract class SearchedRecipesState extends Equatable {
  const SearchedRecipesState();

  @override
  List<Object> get props => [];
}

class SearchedRecipesInitial extends SearchedRecipesState {}

class SearchedRecipesLoading extends SearchedRecipesState {}

class SearchedRecipesLoaded extends SearchedRecipesState {
  final List<PopularRecipeEntity> recipes;

  const SearchedRecipesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class SearchedRecipesError extends SearchedRecipesState {
  final String message;

  const SearchedRecipesError(this.message);

  @override
  List<Object> get props => [message];
}