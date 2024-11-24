import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/preference_domain.dart';
import '../../../domain/usecases/fetch_cuisine_use_case.dart';
part 'fetch_cuisine_event.dart';
part 'fetch_cuisine_state.dart';

class FetchCuisineBloc extends Bloc<FetchCuisineEvent, FetchCuisineState> {
  final FetchCuisineUseCase fetchCuisineUseCase;

  FetchCuisineBloc({required this.fetchCuisineUseCase})
      : super(FetchCuisineInitial()) {
    on<FetchCuisinesEvent>((event, emit) async {
      emit(FetchCuisineLoading());
      try {
        final cuisines = await fetchCuisineUseCase.execute();
        emit(FetchCuisineSuccess(cuisines: cuisines));
      } catch (e) {
        emit(FetchCuisineFailure(error: e.toString()));
      }
    });
  }
}
