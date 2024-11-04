part of 'collection_recipe_bloc.dart';

abstract class CollectionRecipeEvent extends Equatable {
  const CollectionRecipeEvent();

  @override
  List<Object> get props => [];
}

class FetchCollectionRecipesEvent extends CollectionRecipeEvent {
  final int id;

  const FetchCollectionRecipesEvent(this.id);

  @override
  List<Object> get props => [id];
}