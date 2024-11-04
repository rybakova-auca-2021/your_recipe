part of 'filtered_recipe_bloc.dart';

abstract class FilteredRecipesEvent extends Equatable {
  const FilteredRecipesEvent();

  @override
  List<Object> get props => [];
}

class FetchFilteredRecipesEvent extends FilteredRecipesEvent {
  final Map<String, dynamic> filters;

  const FetchFilteredRecipesEvent(this.filters);

  @override
  List<Object> get props => [filters];
}