import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_preferred_cuisine_use_case.dart';
part 'add_cuisine_event.dart';
part 'add_cuisine_state.dart';

class AddPreferredCuisineBloc
    extends Bloc<AddPreferredCuisineEvent, AddPreferredCuisineState> {
  final AddPreferredCuisineUseCase addPreferredCuisineUseCase;

  AddPreferredCuisineBloc({required this.addPreferredCuisineUseCase})
      : super(AddPreferredCuisineInitial()) {
    on<SubmitPreferredCuisinesEvent>((event, emit) async {
      emit(AddPreferredCuisineLoading());
      try {
        await addPreferredCuisineUseCase.execute(event.cuisineIds);
        emit(AddPreferredCuisineSuccess());
      } catch (e) {
        emit(AddPreferredCuisineFailure(error: e.toString()));
      }
    });
  }
}
