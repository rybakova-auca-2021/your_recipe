part of 'category_recipes_bloc.dart';

abstract class CategoryRecipesState extends Equatable {
  const CategoryRecipesState();

  @override
  List<Object> get props => [];
}

class CategoryRecipesInitial extends CategoryRecipesState {}

class CategoryRecipesLoading extends CategoryRecipesState {}

class CategoryRecipesLoaded extends CategoryRecipesState {
  final List<RecipeDetailEntity> recipes;

  const CategoryRecipesLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class CategoryRecipesError extends CategoryRecipesState {
  final String message;

  const CategoryRecipesError(this.message);

  @override
  List<Object> get props => [message];
}