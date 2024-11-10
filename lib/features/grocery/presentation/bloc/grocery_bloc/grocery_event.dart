part of 'grocery_bloc.dart';
abstract class GroceryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllGroceriesViewed extends GroceryEvent {}
class GroceryAdded extends GroceryEvent {
  final String name;
  final String? quantity;

  GroceryAdded({required this.name, this.quantity});
}
class GroceriesAdded extends GroceryEvent {
  final List<GroceryItemEntity> groceries;

  GroceriesAdded(this.groceries);
}
class AllGroceriesDeleted extends GroceryEvent {}
class GroceryDeleted extends GroceryEvent {
  final int id;

  GroceryDeleted(this.id);
}
class GroceryEdited extends GroceryEvent {
  final int id;
  final String name;
  final String? quantity;

  GroceryEdited({required this.id, required this.name, this.quantity});
}
