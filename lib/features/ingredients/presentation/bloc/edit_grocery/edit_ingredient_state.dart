part of 'edit_ingredient_bloc.dart';

abstract class EditIngredientState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditIngredientInitial extends EditIngredientState {}

class EditIngredientLoading extends EditIngredientState {}

class EditIngredientSuccess extends EditIngredientState {
  final Ingredient ingredientItem;

  EditIngredientSuccess(this.ingredientItem);

  @override
  List<Object> get props => [ingredientItem];
}

class EditIngredientError extends EditIngredientState {
  final String message;

  EditIngredientError(this.message);

  @override
  List<Object?> get props => [message];
}
