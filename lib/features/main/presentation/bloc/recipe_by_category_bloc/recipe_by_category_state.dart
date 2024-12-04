part of 'recipe_by_category_bloc.dart';

abstract class RecipesByCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecipesByCategoryInitial extends RecipesByCategoryState {}

class RecipesByCategoryLoading extends RecipesByCategoryState {}

class RecipesByCategorySuccess extends RecipesByCategoryState {
  final List<RecipeDetailEntity> recipes;

  RecipesByCategorySuccess(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipesByCategoryFailure extends RecipesByCategoryState {
  final String message;

  RecipesByCategoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
