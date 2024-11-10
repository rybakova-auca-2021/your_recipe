part of 'grocery_bloc.dart';

// State declarations
abstract class GroceryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroceryInitial extends GroceryState {}
class GroceryLoading extends GroceryState {}
class GroceryError extends GroceryState {
  final String message;

  GroceryError(this.message);

  @override
  List<Object?> get props => [message];
}

class ViewAllGroceriesSuccess extends GroceryState {
  final List<GroceryItemResponseEntity> groceries;

  ViewAllGroceriesSuccess(this.groceries);

  @override
  List<Object?> get props => [groceries];
}

class AddGrocerySuccess extends GroceryState {}
class AddGroceriesSuccess extends GroceryState {}
class DeleteGrocerySuccess extends GroceryState {}
class DeleteAllGroceriesSuccess extends GroceryState {}
class EditGrocerySuccess extends GroceryState {
  final GroceryItemEntity groceryItem;

  EditGrocerySuccess(this.groceryItem);

  @override
  List<Object?> get props => [groceryItem];
}