import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/add_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_all_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/view_ingredients_usecase.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final AddIngredientUseCase addUseCase;
  final DeleteAllIngredientsUseCase deleteAllUseCase;
  final DeleteIngredientUseCase deleteUseCase;
  final EditIngredientUseCase editUseCase;
  final ViewIngredientsUseCase viewUseCase;

  List<Ingredient> _ingredients = [];

  IngredientBloc({
    required this.addUseCase,
    required this.deleteAllUseCase,
    required this.deleteUseCase,
    required this.editUseCase,
    required this.viewUseCase,
  }) : super(IngredientInitial()) {
    on<AddIngredient>(_onAddIngredient);
    on<DeleteAllIngredients>(_onDeleteAllIngredients);
    on<DeleteIngredient>(_onDeleteIngredient);
    on<EditIngredient>(_onEditIngredient);
    on<ViewAllIngredients>(_onViewAllIngredients);
  }

  Future<void> _onAddIngredient(AddIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    try {
      await addUseCase(Ingredient(
        name: event.name,
        quantity: event.quantity,
        manufactureDate: event.manufactureDate,
        expirationDate: event.expirationDate,
        category: event.category,
      ));
      emit(IngredientAddSuccess());
      final ingredients = await viewUseCase(event.category);
      emit(IngredientViewSuccess(ingredients));
    } catch (e) {
      emit(IngredientError("Adding ingredient failed: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteAllIngredients(DeleteAllIngredients event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    try {
      await deleteAllUseCase(null);
      emit(IngredientDeleteAllSuccess());
      add(ViewAllIngredients(category: event.category));
    } catch (e) {
      emit(IngredientError("Deleting all ingredients failed: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteIngredient(DeleteIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    try {
      await deleteUseCase(event.id);
      emit(IngredientDeleteSuccess());
      add(ViewAllIngredients(category: event.category));
    } catch (e) {
      emit(IngredientError("Deleting ingredient failed: ${e.toString()}"));
    }
  }

  Future<void> _onEditIngredient(EditIngredient event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
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

      await editUseCase(params);
      emit(IngredientEditSuccess(ingredientItem));
      add(ViewAllIngredients(category: event.category));
    } catch (e) {
      emit(IngredientError("Editing ingredient failed: ${e.toString()}"));
    }
  }

  Future<void> _onViewAllIngredients(ViewAllIngredients event, Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    try {
      _ingredients = await viewUseCase(event.category);
      emit(IngredientViewSuccess(_ingredients));
    } catch (e) {
      emit(IngredientError("Viewing ingredients failed: ${e.toString()}"));
    }
  }
}