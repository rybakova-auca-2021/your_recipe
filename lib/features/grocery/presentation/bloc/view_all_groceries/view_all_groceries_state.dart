part of 'view_all_groceries_bloc.dart';

abstract class ViewAllGroceriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewAllGroceriesInitial extends ViewAllGroceriesState {}

class ViewAllGroceriesLoading extends ViewAllGroceriesState {}

class ViewAllGroceriesSuccess extends ViewAllGroceriesState {
  final List<GroceryItemResponseEntity> groceries;

  ViewAllGroceriesSuccess(this.groceries);

  @override
  List<Object> get props => [groceries];
}

class ViewAllGroceriesError extends ViewAllGroceriesState {
  final String message;

  ViewAllGroceriesError(this.message);

  @override
  List<Object> get props => [message];
}
