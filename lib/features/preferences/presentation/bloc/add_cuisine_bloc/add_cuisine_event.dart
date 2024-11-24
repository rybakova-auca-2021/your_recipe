part of 'add_cuisine_bloc.dart';

abstract class AddPreferredCuisineEvent {}

class SubmitPreferredCuisinesEvent extends AddPreferredCuisineEvent {
  final List<int> cuisineIds;

  SubmitPreferredCuisinesEvent({required this.cuisineIds});
}
