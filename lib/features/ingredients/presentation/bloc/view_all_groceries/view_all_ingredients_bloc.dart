import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/view_ingredients_usecase.dart';

part 'view_all_ingredients_event.dart';
part 'view_all_ingredients_state.dart';

class ViewAllIngredientsBloc extends Bloc<ViewAllIngredientsEvent, ViewAllIngredientsState> {
  final ViewIngredientsUseCase usecase;
  List<Ingredient> _ingredients = [];

  ViewAllIngredientsBloc(this.usecase) : super(ViewAllIngredientsInitial()) {
    on<AllIngredientsViewed>(_onAllIngredientsViewed);
  }

  Future<void> _onAllIngredientsViewed(AllIngredientsViewed event, Emitter<ViewAllIngredientsState> emit) async {
    print("Event triggered: AllIngredientsViewed with category ${event.category}");
    emit(ViewAllIngredientsLoading());
    try {
      print("Loading ingredients...");
      _ingredients = await usecase(event.category);
      print("Ingredients loaded successfully: $_ingredients");
      emit(ViewAllIngredientsSuccess(_ingredients));
    } catch (e) {
      print("Error occurred while viewing ingredients: $e");
      emit(ViewAllIngredientsError("Viewing ingredients failed: ${e.toString()}"));
    }
  }
}
