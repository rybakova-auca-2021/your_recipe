
part of 'add_grocery_bloc.dart';

abstract class AddGroceryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddGroceryInitial extends AddGroceryState {}

class AddGroceryLoading extends AddGroceryState {}

class AddGrocerySuccess extends AddGroceryState {
  AddGrocerySuccess();
}

class AddGroceryError extends AddGroceryState {
  final String message;

  AddGroceryError(this.message);

  @override
  List<Object?> get props => [message];
}
