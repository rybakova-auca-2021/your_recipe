part of 'delete_all_ingredients_bloc.dart';

abstract class DeleteAllIngredientsEvent extends Equatable {
  const DeleteAllIngredientsEvent();
  @override
  List<Object> get props => [];
}

class AllIngredientsDeleted extends DeleteAllIngredientsEvent {
  final String category;

  const AllIngredientsDeleted({required this.category});

  @override
  List<Object> get props => [category];
}
