import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/add_ingredient_usecase.dart';

import '../view_all_groceries/view_all_ingredients_bloc.dart';

part 'add_ingredient_event.dart';
part 'add_ingredient_state.dart';

class AddIngredientBloc extends Bloc<AddIngredientEvent, AddIngredientState> {
  final AddIngredientUseCase usecase;
  final ViewAllIngredientsBloc viewAllIngredientsBloc;

  AddIngredientBloc(this.usecase, this.viewAllIngredientsBloc) : super(AddIngredientInitial()) {
    on<IngredientAdded>(_onIngredientAdded);
  }

  Future<void> _onIngredientAdded(IngredientAdded event, Emitter<AddIngredientState> emit) async {
    emit(AddIngredientLoading());
    try {
      await usecase(
        Ingredient(
          name: event.name,
          quantity: event.quantity,
          manufactureDate: event.manufactureDate,
          expirationDate: event.expirationDate,
          category: event.category,
        ),
      );
      emit(AddIngredientSuccess());
    } catch (e) {
      emit(AddIngredientError("Adding ingredient failed: ${e.toString()}"));
    }
  }
}
