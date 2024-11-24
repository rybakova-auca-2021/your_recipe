import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/preference_domain.dart';
import '../../../domain/usecases/fetch_food_use_case.dart';

part 'fetch_food_event.dart';
part 'fetch_food_state.dart';

class FetchFoodBloc extends Bloc<FetchFoodEvent, FetchFoodState> {
  final FetchFoodUseCase fetchFoodUseCase;

  FetchFoodBloc({required this.fetchFoodUseCase})
      : super(FetchFoodInitial()) {
    on<FetchFoodEvent>((event, emit) async {
      emit(FetchFoodLoading());
      try {
        final cuisines = await fetchFoodUseCase.execute();
        emit(FetchFoodSuccess(cuisines: cuisines));
      } catch (e) {
        emit(FetchFoodFailure(error: e.toString()));
      }
    });
  }
}
