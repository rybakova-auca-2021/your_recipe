part of 'add_ingredient_bloc.dart';

abstract class AddIngredientState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddIngredientInitial extends AddIngredientState {}

class AddIngredientLoading extends AddIngredientState {}

class AddIngredientSuccess extends AddIngredientState {}

class AddIngredientError extends AddIngredientState {
  final String message;

  AddIngredientError(this.message);

  @override
  List<Object?> get props => [message];
}
