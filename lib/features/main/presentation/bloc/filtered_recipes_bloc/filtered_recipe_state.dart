part of 'filtered_recipe_bloc.dart';

abstract class FilteredRecipesState extends Equatable {
  const FilteredRecipesState();

  @override
  List<Object> get props => [];
}

class FilteredRecipesInitial extends FilteredRecipesState {}

class FilteredRecipesLoading extends FilteredRecipesState {}

class FilteredRecipesLoaded extends FilteredRecipesState {
  final List<RecipeDetailEntity> recipes;

  const FilteredRecipesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class FilteredRecipesError extends FilteredRecipesState {
  final String message;

  const FilteredRecipesError(this.message);

  @override
  List<Object> get props => [message];
}