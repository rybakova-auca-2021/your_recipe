import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/features/main/domain/entity/collection_entity.dart';
import '../../../domain/usecase/view_collections_use_case.dart';

part 'collection_event.dart';
part 'collection_state.dart';

// Bloc
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final ViewCollectionsUseCase viewCollectionsUseCase;

  CollectionsBloc(this.viewCollectionsUseCase) : super(CollectionsInitial()) {
    on<FetchCollectionsEvent>((event, emit) async {
      emit(CollectionsLoading());

      try {
        final collections = await viewCollectionsUseCase(null);
        emit(CollectionsLoaded(collections));
      } catch (error) {
        emit(CollectionsError(error.toString()));
      }
    });
  }
}
