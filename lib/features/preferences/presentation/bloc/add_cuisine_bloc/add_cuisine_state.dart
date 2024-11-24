part of 'add_cuisine_bloc.dart';

abstract class AddPreferredCuisineState {}

class AddPreferredCuisineInitial extends AddPreferredCuisineState {}

class AddPreferredCuisineLoading extends AddPreferredCuisineState {}

class AddPreferredCuisineSuccess extends AddPreferredCuisineState {}

class AddPreferredCuisineFailure extends AddPreferredCuisineState {
  final String error;

  AddPreferredCuisineFailure({required this.error});
}
