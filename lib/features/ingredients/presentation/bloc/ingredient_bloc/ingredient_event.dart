part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddIngredient extends IngredientEvent {
  final String name;
  final String quantity;
  final String manufactureDate;
  final String expirationDate;
  final String category;

  AddIngredient({
    required this.name,
    required this.quantity,
    required this.manufactureDate,
    required this.expirationDate,
    required this.category,
  });
}

class DeleteAllIngredients extends IngredientEvent {
  final String category;

  DeleteAllIngredients({required this.category});
}

class DeleteIngredient extends IngredientEvent {
  final int id;
  final String category;

  DeleteIngredient({required this.id, required this.category});
}

class EditIngredient extends IngredientEvent {
  final int? id;
  final String name;
  final String? quantity;
  final String manufactureDate;
  final String expirationDate;
  final String category;

  EditIngredient({
    this.id,
    required this.name,
    this.quantity,
    required this.manufactureDate,
    required this.expirationDate,
    required this.category,
  });
}

class ViewAllIngredients extends IngredientEvent {
  final String category;

  ViewAllIngredients({required this.category});
}