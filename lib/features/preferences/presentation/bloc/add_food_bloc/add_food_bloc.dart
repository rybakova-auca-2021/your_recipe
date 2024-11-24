import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_preferred_food_use_case.dart';
part 'add_food_event.dart';
part 'add_food_state.dart';

class AddPreferredFoodBloc
    extends Bloc<AddPreferredFoodEvent, AddPreferredFoodState> {
  final AddPreferredFoodUseCase addPreferredFoodUseCase;

  AddPreferredFoodBloc({required this.addPreferredFoodUseCase})
      : super(AddPreferredFoodInitial()) {
    on<SubmitPreferredFoodEvent>((event, emit) async {
      emit(AddPreferredFoodLoading());
      try {
        await addPreferredFoodUseCase.execute(event.foodIds);
        emit(AddPreferredFoodSuccess());
      } catch (e) {
        emit(AddPreferredFoodFailure(error: e.toString()));
      }
    });
  }
}
