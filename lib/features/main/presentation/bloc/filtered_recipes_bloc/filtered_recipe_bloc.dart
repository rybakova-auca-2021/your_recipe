import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/recipe_detail_entity.dart';
import '../../../domain/usecase/view_filtered_recipes_use_case.dart';

part 'filtered_recipe_event.dart';
part 'filtered_recipe_state.dart';

class FilteredRecipesBloc extends Bloc<FilteredRecipesEvent, FilteredRecipesState> {
  final ViewFilteredRecipesUseCase viewFilteredRecipesUseCase;

  FilteredRecipesBloc(this.viewFilteredRecipesUseCase) : super(FilteredRecipesInitial()) {
    on<FetchFilteredRecipesEvent>((event, emit) async {
      emit(FilteredRecipesLoading());

      try {
        final recipes = await viewFilteredRecipesUseCase(event.filters);
        emit(FilteredRecipesLoaded(recipes));
      } catch (error) {
        emit(FilteredRecipesError(error.toString()));
      }
    });
  }
}