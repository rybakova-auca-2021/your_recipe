import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/delete_all_groceries_usecase.dart';
import '../view_all_groceries/view_all_groceries_bloc.dart';

part 'delete_all_groceries_event.dart';
part 'delete_all_groceries_state.dart';

class DeleteAllGroceriesBloc extends Bloc<DeleteAllGroceriesEvent, DeleteAllGroceriesState> {
  final DeleteAllGroceriesUsecase usecase;
  final ViewAllGroceriesBloc viewAllGroceriesBloc;

  DeleteAllGroceriesBloc(this.usecase, this.viewAllGroceriesBloc) : super(DeleteAllGroceriesInitial()) {
    on<AllGroceriesDeleted>(_onAllGroceriesDeleted);
  }

  Future<void> _onAllGroceriesDeleted(AllGroceriesDeleted event, Emitter<DeleteAllGroceriesState> emit) async {
    emit(DeleteAllGroceriesLoading());
    try {
      await usecase(null);
      emit(DeleteAllGroceriesSuccess());

      viewAllGroceriesBloc.add(AllGroceriesViewed());
    } catch (e) {
      emit(DeleteAllGroceriesError("Deleting all groceries failed: ${e.toString()}"));
    }
  }
}
