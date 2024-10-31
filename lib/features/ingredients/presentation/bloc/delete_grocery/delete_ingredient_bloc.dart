import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/view_all_groceries/view_all_ingredients_bloc.dart';

part 'delete_ingredient_event.dart';
part 'delete_ingredient_state.dart';

class DeleteIngredientBloc extends Bloc<DeleteIngredientEvent, DeleteIngredientState> {
  final DeleteIngredientUseCase usecase;
  final ViewAllIngredientsBloc viewAllIngredientsBloc;

  DeleteIngredientBloc(this.usecase, this.viewAllIngredientsBloc) : super(DeleteIngredientInitial()) {
    on<IngredientDeleted>(_onIngredientDeleted);
  }

  Future<void> _onIngredientDeleted(IngredientDeleted event, Emitter<DeleteIngredientState> emit) async {
    emit(DeleteIngredientLoading());

    try {
      await usecase(event.id);
      emit(DeleteIngredientSuccess());

      viewAllIngredientsBloc.add(AllIngredientsViewed(category: event.category));

    } catch (e) {
      emit(DeleteIngredientError("Deleting ingredient failed: ${e.toString()}"));
    }
  }
}

