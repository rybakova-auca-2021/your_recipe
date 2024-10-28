part of 'view_all_groceries_bloc.dart';

abstract class ViewAllGroceriesEvent extends Equatable {
  const ViewAllGroceriesEvent();

  @override
  List<Object> get props => [];
}

class AllGroceriesViewed extends ViewAllGroceriesEvent {}
