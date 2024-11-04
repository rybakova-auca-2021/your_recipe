part of 'popular_recipes_bloc.dart';

abstract class PopularRecipesEvent extends Equatable {
  const PopularRecipesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularRecipesEvent extends PopularRecipesEvent {
  final String period;

  const FetchPopularRecipesEvent(this.period);

  @override
  List<Object> get props => [period];
}