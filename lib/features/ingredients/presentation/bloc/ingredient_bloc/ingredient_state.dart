part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientLoading extends IngredientState {}

class IngredientAddSuccess extends IngredientState {}

class IngredientDeleteAllSuccess extends IngredientState {}

class IngredientDeleteSuccess extends IngredientState {}

class IngredientEditSuccess extends IngredientState {
  final Ingredient ingredient;

  IngredientEditSuccess(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class IngredientViewSuccess extends IngredientState {
  final List<Ingredient> ingredients;

  IngredientViewSuccess(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

class IngredientError extends IngredientState {
  final String message;

  IngredientError(this.message);

  @override
  List<Object?> get props => [message];
}
