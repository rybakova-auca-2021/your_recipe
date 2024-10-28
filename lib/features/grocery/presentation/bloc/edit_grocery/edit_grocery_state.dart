
part of 'edit_grocery_bloc.dart';

abstract class EditGroceryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditGroceryInitial extends EditGroceryState {}

class EditGroceryLoading extends EditGroceryState {}

class EditGrocerySuccess extends EditGroceryState {
  final GroceryItemEntity groceryItem;

  EditGrocerySuccess(this.groceryItem);

  @override
  List<Object> get props => [groceryItem];
}

class EditGroceryError extends EditGroceryState {
  final String message;

  EditGroceryError(this.message);

  @override
  List<Object?> get props => [message];
}
