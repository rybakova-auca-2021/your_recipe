import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import 'package:your_recipe/features/grocery/domain/usecase/view_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_groceries_use_case.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_all_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/edit_grocery_usecase.dart';

part 'grocery_event.dart';
part 'grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  final ViewGroceriesUsecase viewUsecase;
  final AddGroceryUsecase addUsecase;
  final AddGroceriesUseCase addMultipleUsecase;
  final DeleteAllGroceriesUsecase deleteAllUsecase;
  final DeleteGroceryUsecase deleteUsecase;
  final EditGroceryUsecase editUsecase;

  GroceryBloc({
    required this.viewUsecase,
    required this.addUsecase,
    required this.addMultipleUsecase,
    required this.deleteAllUsecase,
    required this.deleteUsecase,
    required this.editUsecase,
  }) : super(GroceryInitial()) {
    on<AllGroceriesViewed>(_onAllGroceriesViewed);
    on<GroceryAdded>(_onGroceryAdded);
    on<GroceriesAdded>(_onGroceriesAdded);
    on<AllGroceriesDeleted>(_onAllGroceriesDeleted);
    on<GroceryDeleted>(_onGroceryDeleted);
    on<GroceryEdited>(_onGroceryEdited);
  }

  Future<void> _onAllGroceriesViewed(AllGroceriesViewed event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Viewing groceries failed: ${e.toString()}"));
    }
  }

  Future<void> _onGroceryAdded(GroceryAdded event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      await addUsecase(GroceryItemEntity(name: event.name, quantity: event.quantity ?? "1"));
      emit(AddGrocerySuccess());
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Adding grocery failed: ${e.toString()}"));
    }
  }

  Future<void> _onGroceriesAdded(GroceriesAdded event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      await addMultipleUsecase(event.groceries);
      emit(AddGroceriesSuccess());
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Adding multiple groceries failed: ${e.toString()}"));
    }
  }

  Future<void> _onAllGroceriesDeleted(AllGroceriesDeleted event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      await deleteAllUsecase(null);
      emit(DeleteAllGroceriesSuccess());
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Deleting all groceries failed: ${e.toString()}"));
    }
  }

  Future<void> _onGroceryDeleted(GroceryDeleted event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      await deleteUsecase(event.id);
      emit(DeleteGrocerySuccess());
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Deleting grocery failed: ${e.toString()}"));
    }
  }

  Future<void> _onGroceryEdited(GroceryEdited event, Emitter<GroceryState> emit) async {
    emit(GroceryLoading());
    try {
      final groceryItem = GroceryItemEntity(
        id: event.id,
        name: event.name,
        quantity: event.quantity ?? "1",
      );
      await editUsecase({'id': groceryItem.id, 'groceryItem': groceryItem});
      emit(EditGrocerySuccess(groceryItem));
      final groceries = await viewUsecase(null);
      emit(ViewAllGroceriesSuccess(groceries));
    } catch (e) {
      emit(GroceryError("Editing grocery failed: ${e.toString()}"));
    }
  }
}
