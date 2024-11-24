import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/preference_domain.dart';
import '../../../domain/usecases/get_preferred_cuisine_use_case.dart';

part 'get_preferred_cuisine_event.dart';
part 'get_preferred_cuisine_state.dart';

class GetPreferredCuisineBloc
    extends Bloc<GetPreferredCuisineEvent, GetPreferredCuisineState> {
  final GetPreferredCuisineUseCase getPreferredCuisineUseCase;

  GetPreferredCuisineBloc({required this.getPreferredCuisineUseCase})
      : super(GetPreferredCuisineInitial()) {
    on<LoadPreferredCuisinesEvent>((event, emit) async {
      emit(GetPreferredCuisineLoading());
      try {
        final cuisines = await getPreferredCuisineUseCase.execute();
        emit(GetPreferredCuisineSuccess(cuisines: cuisines));
      } catch (e) {
        emit(GetPreferredCuisineFailure(error: e.toString()));
      }
    });
  }
}
