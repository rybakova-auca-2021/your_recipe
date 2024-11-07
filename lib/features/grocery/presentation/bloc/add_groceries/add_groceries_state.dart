part of 'add_groceries_bloc.dart';

abstract class AddGroceriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddGroceriesInitial extends AddGroceriesState {}

class AddGroceriesLoading extends AddGroceriesState {}

class AddGroceriesSuccess extends AddGroceriesState {}

class AddGroceriesError extends AddGroceriesState {
  final String message;

  AddGroceriesError(this.message);

  @override
  List<Object?> get props => [message];
}
