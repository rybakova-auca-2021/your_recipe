part of 'view_all_ingredients_bloc.dart';

abstract class ViewAllIngredientsEvent extends Equatable {
  const ViewAllIngredientsEvent();

  @override
  List<Object> get props => [];
}

class AllIngredientsViewed extends ViewAllIngredientsEvent {
  final String category;

  const AllIngredientsViewed({required this.category});

  @override
  List<Object> get props => [category];
}
