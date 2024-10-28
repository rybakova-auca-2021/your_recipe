import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_grocery_usecase.dart';
import '../view_all_groceries/view_all_groceries_bloc.dart';

part 'add_grocery_event.dart';
part 'add_grocery_state.dart';

class AddGroceryBloc extends Bloc<AddGroceryEvent, AddGroceryState> {
  final AddGroceryUsecase usecase;
  final ViewAllGroceriesBloc viewAllGroceriesBloc;

  AddGroceryBloc(this.usecase, this.viewAllGroceriesBloc) : super(AddGroceryInitial()) {
    on<GroceryAdded>(_onGroceryAdded);
  }

  Future<void> _onGroceryAdded(GroceryAdded event, Emitter<AddGroceryState> emit) async {
    emit(AddGroceryLoading());
    try {
      await usecase(GroceryItemEntity(name: event.name, quantity: event.quantity ?? "1"));
      emit(AddGrocerySuccess());
      viewAllGroceriesBloc.add(AllGroceriesViewed());
    } catch (e) {
      emit(AddGroceryError("Adding grocery failed: ${e.toString()}"));
    }
  }
}
