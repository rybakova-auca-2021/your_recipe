import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/recipe_entity.dart';
import '../../../domain/usecase/fetch_recipe_of_the_day_use_case.dart';

part 'daily_recipe_event.dart';
part 'daily_recipe_state.dart';

class RecipeOfTheDayBloc extends Bloc<RecipeOfTheDayEvent, RecipeOfTheDayState> {
  final FetchRecipeOfTheDayUseCase fetchRecipeOfTheDayUseCase;

  RecipeOfTheDayBloc(this.fetchRecipeOfTheDayUseCase) : super(RecipeOfTheDayInitial()) {
    on<FetchRecipeOfTheDayEvent>(_onFetchRecipeOfTheDay);
  }

  Future<void> _onFetchRecipeOfTheDay(
      FetchRecipeOfTheDayEvent event, Emitter<RecipeOfTheDayState> emit) async {
    emit(RecipeOfTheDayLoading());
    try {
      final recipe = await fetchRecipeOfTheDayUseCase(null);
      emit(RecipeOfTheDayLoaded(recipe));
    } catch (e) {
      emit(RecipeOfTheDayError(e.toString()));
    }
  }
}
