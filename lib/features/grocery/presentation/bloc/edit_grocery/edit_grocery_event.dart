part of 'edit_grocery_bloc.dart';

abstract class EditGroceryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroceryEdited extends EditGroceryEvent {
  final int? id;
  final String name;
  final String? quantity;

  GroceryEdited({this.id, required this.name, this.quantity});

  @override
  List<Object?> get props => [id, name, quantity];
}
