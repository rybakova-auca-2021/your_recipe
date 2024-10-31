part of 'delete_all_ingredients_bloc.dart';

abstract class DeleteAllIngredientsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteAllIngredientsInitial extends DeleteAllIngredientsState {}

class DeleteAllIngredientsLoading extends DeleteAllIngredientsState {}

class DeleteAllIngredientsSuccess extends DeleteAllIngredientsState {}

class DeleteAllIngredientsError extends DeleteAllIngredientsState {
  final String message;

  DeleteAllIngredientsError(this.message);

  @override
  List<Object> get props => [message];
}
