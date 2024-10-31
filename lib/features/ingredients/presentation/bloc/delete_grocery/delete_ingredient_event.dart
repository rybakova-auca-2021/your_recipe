part of 'delete_ingredient_bloc.dart';

abstract class DeleteIngredientEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IngredientDeleted extends DeleteIngredientEvent {
  final int id;
  final String category;

  IngredientDeleted({required this.id, required this.category});

  @override
  List<Object> get props => [id, category];
}
