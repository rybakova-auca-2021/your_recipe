part of 'fetch_favorite_bloc.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List<PopularRecipeEntity> recipes;

  FavoritesSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class FavoritesFailure extends FavoritesState {
  final String error;

  FavoritesFailure(this.error);

  @override
  List<Object> get props => [error];
}
