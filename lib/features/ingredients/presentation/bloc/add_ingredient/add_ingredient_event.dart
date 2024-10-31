part of 'add_ingredient_bloc.dart';

abstract class AddIngredientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IngredientAdded extends AddIngredientEvent {
  final String name;
  final String? quantity;
  final String? manufactureDate;
  final String? expirationDate;
  final String category;

  IngredientAdded({
    required this.name,
    this.quantity,
    this.manufactureDate,
    this.expirationDate,
    required this.category,
  });

  @override
  List<Object?> get props => [name, quantity, manufactureDate, expirationDate, category];
}
