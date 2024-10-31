part of 'view_all_ingredients_bloc.dart';

abstract class ViewAllIngredientsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewAllIngredientsInitial extends ViewAllIngredientsState {}

class ViewAllIngredientsLoading extends ViewAllIngredientsState {}

class ViewAllIngredientsSuccess extends ViewAllIngredientsState {
  final List<Ingredient> ingredients;

  ViewAllIngredientsSuccess(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}

class ViewAllIngredientsError extends ViewAllIngredientsState {
  final String message;

  ViewAllIngredientsError(this.message);

  @override
  List<Object> get props => [message];
}
