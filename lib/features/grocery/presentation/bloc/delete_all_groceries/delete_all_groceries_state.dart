part of 'delete_all_groceries_bloc.dart';

abstract class DeleteAllGroceriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteAllGroceriesInitial extends DeleteAllGroceriesState {}

class DeleteAllGroceriesLoading extends DeleteAllGroceriesState {}

class DeleteAllGroceriesSuccess extends DeleteAllGroceriesState {}

class DeleteAllGroceriesError extends DeleteAllGroceriesState {
  final String message;

  DeleteAllGroceriesError(this.message);

  @override
  List<Object> get props => [message];
}
