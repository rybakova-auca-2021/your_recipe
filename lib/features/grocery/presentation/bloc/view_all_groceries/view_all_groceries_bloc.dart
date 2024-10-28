import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import '../../../domain/usecase/view_groceries_usecase.dart';

part 'view_all_groceries_event.dart';
part 'view_all_groceries_state.dart';

class ViewAllGroceriesBloc extends Bloc<ViewAllGroceriesEvent, ViewAllGroceriesState> {
  final ViewGroceriesUsecase usecase;
  List<GroceryItemResponseEntity> _groceries = [];

  ViewAllGroceriesBloc(this.usecase) : super(ViewAllGroceriesInitial()) {
    on<AllGroceriesViewed>(_onAllGroceriesViewed);
  }

  Future<void> _onAllGroceriesViewed(AllGroceriesViewed event, Emitter<ViewAllGroceriesState> emit) async {
    emit(ViewAllGroceriesLoading());
    try {
      _groceries = await usecase(null);
      emit(ViewAllGroceriesSuccess(_groceries));
    } catch (e) {
      emit(ViewAllGroceriesError("Viewing groceries failed: ${e.toString()}"));
    }
  }
}
