part of 'add_groceries_bloc.dart';

abstract class AddGroceriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroceriesAdded extends AddGroceriesEvent {
  final List<GroceryItemEntity> groceries;

  GroceriesAdded({required this.groceries});

  @override
  List<Object?> get props => [groceries];
}
