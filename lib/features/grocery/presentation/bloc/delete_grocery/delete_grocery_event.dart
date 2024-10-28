part of 'delete_grocery_bloc.dart';

abstract class DeleteGroceryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GroceryDeleted extends DeleteGroceryEvent {
  final int id; 

  GroceryDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
