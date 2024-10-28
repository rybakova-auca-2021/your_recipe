import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/usecase/edit_grocery_usecase.dart';
import '../view_all_groceries/view_all_groceries_bloc.dart';

part 'edit_grocery_event.dart';
part 'edit_grocery_state.dart';

class EditGroceryBloc extends Bloc<EditGroceryEvent, EditGroceryState> {
  final EditGroceryUsecase usecase;
  final ViewAllGroceriesBloc viewAllGroceriesBloc;

  EditGroceryBloc(this.usecase, this.viewAllGroceriesBloc) : super(EditGroceryInitial()) {
    on<GroceryEdited>(_onGroceryEdited);
  }

  Future<void> _onGroceryEdited(GroceryEdited event, Emitter<EditGroceryState> emit) async {
    emit(EditGroceryLoading());
    try {
      final groceryItem = GroceryItemEntity(
        id: event.id,
        name: event.name,
        quantity: event.quantity ?? "1",
      );

      final params = {
        'id': groceryItem.id,
        'groceryItem': groceryItem,
      };

      await usecase(params);
      emit(EditGrocerySuccess(groceryItem));
    } catch (e) {
      emit(EditGroceryError("Editing grocery failed: ${e.toString()}"));
    }
  }
}
