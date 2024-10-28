import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/delete_grocery_usecase.dart';
import '../view_all_groceries/view_all_groceries_bloc.dart';

part 'delete_grocery_event.dart';
part 'delete_grocery_state.dart';

class DeleteGroceryBloc extends Bloc<DeleteGroceryEvent, DeleteGroceryState> {
  final DeleteGroceryUsecase usecase;
  final ViewAllGroceriesBloc viewAllGroceriesBloc;

  DeleteGroceryBloc(this.usecase, this.viewAllGroceriesBloc) : super(DeleteGroceryInitial()) {
    on<GroceryDeleted>(_onGroceryDeleted);
  }

  Future<void> _onGroceryDeleted(GroceryDeleted event, Emitter<DeleteGroceryState> emit) async {
    emit(DeleteGroceryLoading());
    try {
      await usecase(event.id);
      emit(DeleteGrocerySuccess());

      viewAllGroceriesBloc.add(AllGroceriesViewed());
    } catch (e) {
      emit(DeleteGroceryError("Deleting grocery failed: ${e.toString()}"));
    }
  }
}
