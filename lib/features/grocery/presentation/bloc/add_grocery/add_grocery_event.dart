part of 'add_grocery_bloc.dart';

abstract class AddGroceryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroceryAdded extends AddGroceryEvent {
  final String name;
  final String? quantity;

  GroceryAdded({required this.name, this.quantity});

  @override
  List<Object?> get props => [name, quantity];
}
