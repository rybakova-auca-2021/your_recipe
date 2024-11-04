part of 'detail_recipe_bloc.dart';

abstract class DetailRecipeEvent extends Equatable {
  const DetailRecipeEvent();

  @override
  List<Object> get props => [];
}

class FetchRecipeDetailEvent extends DetailRecipeEvent {
  final int id;

  const FetchRecipeDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}