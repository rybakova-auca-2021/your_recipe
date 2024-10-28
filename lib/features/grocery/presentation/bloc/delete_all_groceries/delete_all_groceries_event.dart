part of 'delete_all_groceries_bloc.dart';

abstract class DeleteAllGroceriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AllGroceriesDeleted extends DeleteAllGroceriesEvent {}
