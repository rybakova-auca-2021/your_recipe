part of 'delete_ingredient_bloc.dart';

abstract class DeleteIngredientState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteIngredientInitial extends DeleteIngredientState {}

class DeleteIngredientLoading extends DeleteIngredientState {}

class DeleteIngredientSuccess extends DeleteIngredientState {}

class DeleteIngredientError extends DeleteIngredientState {
  final String message;

  DeleteIngredientError(this.message);

  @override
  List<Object> get props => [message];
}
