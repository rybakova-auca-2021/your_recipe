import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_entity.dart';
import '../../../domain/usecase/add_groceries_use_case.dart';
import '../view_all_groceries/view_all_groceries_bloc.dart';

part 'add_groceries_event.dart';
part 'add_groceries_state.dart';

class AddGroceriesBloc extends Bloc<AddGroceriesEvent, AddGroceriesState> {
  final AddGroceriesUseCase usecase;
  final ViewAllGroceriesBloc viewAllGroceriesBloc;

  AddGroceriesBloc(this.usecase, this.viewAllGroceriesBloc) : super(AddGroceriesInitial()) {
    on<GroceriesAdded>(_onGroceriesAdded);
  }

  Future<void> _onGroceriesAdded(GroceriesAdded event, Emitter<AddGroceriesState> emit) async {
    emit(AddGroceriesLoading());
    try {
      await usecase(event.groceries);
      emit(AddGroceriesSuccess());

      viewAllGroceriesBloc.add(AllGroceriesViewed());
    } catch (e) {
      emit(AddGroceriesError("Adding groceries failed: ${e.toString()}"));
    }
  }
}
