import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/preference_domain.dart';
import '../../../domain/usecases/get_preferred_food_use_case.dart';

part 'get_preferred_food_event.dart';
part 'get_preferred_food_state.dart';

class GetPreferredFoodBloc
    extends Bloc<GetPreferredFoodEvent, GetPreferredFoodState> {
  final GetPreferredFoodUseCase getPreferredFoodUseCase;

  GetPreferredFoodBloc({required this.getPreferredFoodUseCase})
      : super(GetPreferredFoodInitial()) {
    on<LoadPreferredFoodsEvent>((event, emit) async {
      emit(GetPreferredFoodLoading());
      try {
        final foods = await getPreferredFoodUseCase.execute();
        emit(GetPreferredFoodSuccess(foods: foods));
      } catch (e) {
        emit(GetPreferredFoodFailure(error: e.toString()));
      }
    });
  }
}
