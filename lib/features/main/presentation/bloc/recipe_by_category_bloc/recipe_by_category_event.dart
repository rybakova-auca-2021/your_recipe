part of 'recipe_by_category_bloc.dart';

abstract class RecipesByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRecipesByCategoryEvent extends RecipesByCategoryEvent {
  final String category;

  FetchRecipesByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
