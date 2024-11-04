part of 'collection_bloc.dart';

abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object> get props => [];
}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoading extends CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<CollectionEntity> collections;

  const CollectionsLoaded(this.collections);

  @override
  List<Object> get props => [collections];
}

class CollectionsError extends CollectionsState {
  final String message;

  const CollectionsError(this.message);

  @override
  List<Object> get props => [message];
}
