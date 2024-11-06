import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/favorite_entity.dart';
import '../../../domain/usecase/save_recipe_use_case.dart';

part 'save_recipe_event.dart';
part 'save_recipe_state.dart';

class RecipeFavoriteBloc extends Bloc<RecipeFavoriteEvent, RecipeFavoriteState> {
  final SaveRecipeUseCase saveRecipeUseCase;

  RecipeFavoriteBloc(this.saveRecipeUseCase) : super(RecipeFavoriteInitial()) {
    on<SaveRecipeEvent>((event, emit) async {
      emit(RecipeFavoriteLoading());

      try {
        final recipes = await saveRecipeUseCase(event.recipeId);
        emit(RecipeFavoriteSuccess(recipes));
      } catch (error) {
        emit(RecipeFavoriteFailure(error.toString()));
      }
    });
  }
}

