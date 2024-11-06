import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main/domain/entity/recipe_entity.dart';
import '../../../../main/domain/usecase/fetch_favorites_use_case.dart';

part 'fetch_favorite_event.dart';
part 'fetch_favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FetchFavoritesUseCase fetchFavoritesUseCase;

  FavoritesBloc(this.fetchFavoritesUseCase) : super(FavoritesInitial()) {
    on<FetchFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());

      try {
        final recipes = await fetchFavoritesUseCase(null);
        emit(FavoritesSuccess(recipes));
      } catch (error) {
        emit(FavoritesFailure(error.toString()));
      }
    });
  }
}
