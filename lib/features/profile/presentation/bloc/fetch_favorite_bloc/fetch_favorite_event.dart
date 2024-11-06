part of 'fetch_favorite_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFavoritesEvent extends FavoritesEvent {}
