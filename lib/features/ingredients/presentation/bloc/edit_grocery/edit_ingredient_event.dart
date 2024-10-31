part of 'edit_ingredient_bloc.dart';

abstract class EditIngredientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IngredientEdited extends EditIngredientEvent {
  final int? id;
  final String name;
  final String? quantity;
  final String? manufactureDate;
  final String? expirationDate;
  final String category;

  IngredientEdited({
    this.id,
    required this.name,
    this.quantity,
    this.manufactureDate,
    this.expirationDate,
    required this.category,
  });

  @override
  List<Object?> get props => [id, name, quantity, manufactureDate, expirationDate, category];
}
