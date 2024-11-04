part of 'collection_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class FetchCollectionsEvent extends CollectionsEvent {}
