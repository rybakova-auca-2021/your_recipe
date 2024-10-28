part of 'delete_grocery_bloc.dart';

abstract class DeleteGroceryState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteGroceryInitial extends DeleteGroceryState {}

class DeleteGroceryLoading extends DeleteGroceryState {}

class DeleteGrocerySuccess extends DeleteGroceryState {}

class DeleteGroceryError extends DeleteGroceryState {
  final String message;

  DeleteGroceryError(this.message);

  @override
  List<Object> get props => [message];
}
