import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipe_detail_use_case.dart';

import '../../../domain/entity/recipe_detail_entity.dart';

part 'detail_recipe_event.dart';
part 'detail_recipe_state.dart';

class DetailRecipeBloc extends Bloc<DetailRecipeEvent, DetailRecipeState> {
  final ViewRecipeDetailUseCase viewRecipeDetailUseCase;

  DetailRecipeBloc(this.viewRecipeDetailUseCase) : super(DetailRecipeInitial()) {
    on<FetchRecipeDetailEvent>((event, emit) async {
      emit(DetailRecipeLoading());

      try {
        final recipe = await viewRecipeDetailUseCase(event.id);
        emit(DetailRecipeLoaded(recipe));
      } catch (error) {
        emit(DetailRecipeError(error.toString()));
      }
    });
  }
}