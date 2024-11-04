part of 'detail_recipe_bloc.dart';

abstract class DetailRecipeState extends Equatable {
  const DetailRecipeState();

  @override
  List<Object> get props => [];
}

class DetailRecipeInitial extends DetailRecipeState {}

class DetailRecipeLoading extends DetailRecipeState {}

class DetailRecipeLoaded extends DetailRecipeState {
  final RecipeDetailEntity recipe;

  const DetailRecipeLoaded(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class DetailRecipeError extends DetailRecipeState {
  final String message;

  const DetailRecipeError(this.message);

  @override
  List<Object> get props => [message];
}