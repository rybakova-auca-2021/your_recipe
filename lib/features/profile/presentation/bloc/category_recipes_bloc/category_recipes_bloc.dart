import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_detail_entity.dart';
import '../../../../main/domain/usecase/fetch_recipes_by_category_use_case.dart';

part 'category_recipes_event.dart';
part 'category_recipes_state.dart';

class CategoryRecipesBloc extends Bloc<CategoryRecipesEvent, CategoryRecipesState> {
  final FetchRecipesByCategoryUseCase viewCategoryRecipesUseCase;

  CategoryRecipesBloc(this.viewCategoryRecipesUseCase) : super(CategoryRecipesInitial()) {
    on<FetchCategoryRecipesEvent>((event, emit) async {
      emit(CategoryRecipesLoading());

      try {
        final recipes = await viewCategoryRecipesUseCase(event.category);
        emit(CategoryRecipesLoaded(recipes));
      } catch (error) {
        emit(CategoryRecipesError(error.toString()));
      }
    });
  }
}
