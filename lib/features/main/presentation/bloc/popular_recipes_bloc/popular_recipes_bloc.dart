import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/recipe_entity.dart';
import '../../../domain/usecase/view_popular_use_case.dart';

part 'popular_recipes_event.dart';
part 'popular_recipes_state.dart';

class PopularRecipesBloc extends Bloc<PopularRecipesEvent, PopularRecipesState> {
  final ViewPopularUseCase viewPopularUseCase;

  PopularRecipesBloc(this.viewPopularUseCase) : super(PopularRecipesInitial()) {
    on<FetchPopularRecipesEvent>((event, emit) async {
      emit(PopularRecipesLoading());

      try {
        final recipes = await viewPopularUseCase(event.period);
        emit(PopularRecipesLoaded(recipes));
      } catch (error) {
        emit(PopularRecipesError(error.toString()));
      }
    });
  }
}
