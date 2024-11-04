part of 'searched_recipes_bloc.dart';

abstract class SearchedRecipesEvent extends Equatable {
  const SearchedRecipesEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchedRecipesEvent extends SearchedRecipesEvent {
  final String searchQuery;

  const FetchSearchedRecipesEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}