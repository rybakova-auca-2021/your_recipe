import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipes_in_collection_use_case.dart';
import '../../../domain/entity/recipe_detail_entity.dart';

part 'collection_recipe_event.dart';
part 'collection_recipe_state.dart';

class CollectionRecipeBloc extends Bloc<CollectionRecipeEvent, CollectionRecipeState> {
  final ViewRecipesInCollectionUseCase viewRecipesInCollectionUseCase;

  CollectionRecipeBloc(this.viewRecipesInCollectionUseCase) : super(CollectionRecipesInitial()) {
    on<FetchCollectionRecipesEvent>((event, emit) async {
      emit(CollectionRecipesLoading());

      try {
        final recipes = await viewRecipesInCollectionUseCase(event.id);
        emit(CollectionRecipesLoaded(recipes));
      } catch (error) {
        emit(CollectionRecipesError(error.toString()));
      }
    });
  }
}