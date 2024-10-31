import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/delete_all_ingredients_usecase.dart';
import '../view_all_groceries/view_all_ingredients_bloc.dart';

part 'delete_all_ingredients_event.dart';
part 'delete_all_ingredients_state.dart';

class DeleteAllIngredientsBloc extends Bloc<DeleteAllIngredientsEvent, DeleteAllIngredientsState> {
  final DeleteAllIngredientsUseCase usecase;
  final ViewAllIngredientsBloc viewAllIngredientsBloc;

  DeleteAllIngredientsBloc(this.usecase, this.viewAllIngredientsBloc) : super(DeleteAllIngredientsInitial()) {
    on<AllIngredientsDeleted>(_onAllIngredientsDeleted);
  }

  Future<void> _onAllIngredientsDeleted(AllIngredientsDeleted event, Emitter<DeleteAllIngredientsState> emit) async {
    emit(DeleteAllIngredientsLoading());
    try {
      await usecase(null);
      emit(DeleteAllIngredientsSuccess());

      viewAllIngredientsBloc.add(AllIngredientsViewed(category: event.category));
    } catch (e) {
      emit(DeleteAllIngredientsError("Deleting all groceries failed: ${e.toString()}"));
    }
  }
}
