import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import '../../../domain/entity/ingredient.dart';
import '../view_all_groceries/view_all_ingredients_bloc.dart';

part 'edit_ingredient_event.dart';
part 'edit_ingredient_state.dart';

class EditIngredientBloc extends Bloc<EditIngredientEvent, EditIngredientState> {
  final EditIngredientUseCase usecase;
  final ViewAllIngredientsBloc viewAllIngredientsBloc;

  EditIngredientBloc(this.usecase, this.viewAllIngredientsBloc) : super(EditIngredientInitial()) {
    on<IngredientEdited>(_onIngredientEdited);
  }

  Future<void> _onIngredientEdited(IngredientEdited event, Emitter<EditIngredientState> emit) async {
    emit(EditIngredientLoading());
    try {
      final ingredientItem = Ingredient(
        id: event.id,
        name: event.name,
        quantity: event.quantity ?? "1",
        manufactureDate: event.manufactureDate,
        expirationDate: event.expirationDate,
        category: event.category,
      );

      final params = {
        'id': ingredientItem.id,
        'ingredientItem': ingredientItem,
      };

      await usecase(params);
      emit(EditIngredientSuccess(ingredientItem));

      // viewAllIngredientsBloc.add(AllIngredientsViewed(category: event.category));
    } catch (e) {
      emit(EditIngredientError("Editing ingredient failed: ${e.toString()}"));
    }
  }
}
