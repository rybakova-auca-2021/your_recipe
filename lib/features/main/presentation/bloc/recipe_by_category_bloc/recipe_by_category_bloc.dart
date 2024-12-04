import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';
import '../../../domain/usecase/fetch_recipes_by_category_use_case.dart';

part 'recipe_by_category_event.dart';
part 'recipe_by_category_state.dart';

class RecipesByCategoryBloc extends Bloc<RecipesByCategoryEvent, RecipesByCategoryState> {
  final FetchRecipesByCategoryUseCase fetchRecipesByCategoryUseCase;

  RecipesByCategoryBloc(this.fetchRecipesByCategoryUseCase) : super(RecipesByCategoryInitial()) {
    on<FetchRecipesByCategoryEvent>((event, emit) async {
      emit(RecipesByCategoryLoading());

      try {
        final recipes = await fetchRecipesByCategoryUseCase.call(event.category);
        emit(RecipesByCategorySuccess(recipes));
      } catch (e) {
        emit(RecipesByCategoryFailure(e.toString()));
      }
    });
  }
}
