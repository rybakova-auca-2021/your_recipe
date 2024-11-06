part of 'save_recipe_bloc.dart';

abstract class RecipeFavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeFavoriteInitial extends RecipeFavoriteState {}

class RecipeFavoriteLoading extends RecipeFavoriteState {}

class RecipeFavoriteSuccess extends RecipeFavoriteState {
  final FavoriteEntity favorite;

  RecipeFavoriteSuccess(this.favorite);

  @override
  List<Object> get props => [favorite];
}

class RecipeFavoriteFailure extends RecipeFavoriteState {
  final String error;

  RecipeFavoriteFailure(this.error);

  @override
  List<Object> get props => [error];
}
