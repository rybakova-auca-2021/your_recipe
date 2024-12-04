part of 'category_recipes_bloc.dart';

abstract class CategoryRecipesEvent extends Equatable {
  const CategoryRecipesEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryRecipesEvent extends CategoryRecipesEvent {
  final String category;

  const FetchCategoryRecipesEvent(this.category);

  @override
  List<Object> get props => [category];
}