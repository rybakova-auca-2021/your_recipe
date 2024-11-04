import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/entity/recipe_entity.dart';
import 'package:your_recipe/features/main/domain/usecase/view_searched_recipes_use_case.dart';

part 'searched_recipes_event.dart';
part 'searched_recipes_state.dart';

class SearchedRecipesBloc extends Bloc<SearchedRecipesEvent, SearchedRecipesState> {
  final ViewSearchedRecipesUseCase viewSearchedRecipesUseCase;

  SearchedRecipesBloc(this.viewSearchedRecipesUseCase) : super(SearchedRecipesInitial()) {
    on<FetchSearchedRecipesEvent>((event, emit) async {
      emit(SearchedRecipesLoading());

      try {
        final recipes = await viewSearchedRecipesUseCase(event.searchQuery);
        emit(SearchedRecipesLoaded(recipes));
      } catch (error) {
        emit(SearchedRecipesError(error.toString()));
      }
    });
  }
}