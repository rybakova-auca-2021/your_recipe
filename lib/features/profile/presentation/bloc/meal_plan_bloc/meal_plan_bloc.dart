import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/meal_plan_create_entity.dart';
import '../../../domain/usecases/meal_plan_use_case.dart';

part 'meal_plan_event.dart';
part 'meal_plan_state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final AddBulkMealPlans addBulkMealPlans;
  final AddMealPlan addMealPlan;
  final DeleteMealPlan deleteMealPlan;
  final GetMealPlan getMealPlan;

  MealPlanBloc({
    required this.addBulkMealPlans,
    required this.addMealPlan,
    required this.deleteMealPlan,
    required this.getMealPlan,
  }) : super(MealPlanInitial()) {
    on<AddBulkMealPlansEvent>((event, emit) async {
      _logEvent(event);
      emit(MealPlanLoading());
      try {
        final result = await addBulkMealPlans.call(event.mealPlans);
        _logSuccess(result);
        emit(MealPlanSuccess(result));
      } catch (e) {
        _logError(e);
        emit(MealPlanFailure(e.toString()));
      }
    });

    on<AddMealPlanEvent>((event, emit) async {
      _logEvent(event);
      emit(MealPlanLoading());
      try {
        final result = await addMealPlan.call(event.mealPlan);
        _logSuccess(result);
        emit(MealPlanSuccess(result));
      } catch (e) {
        _logError(e);
        emit(MealPlanFailure(e.toString()));
      }
    });

    on<DeleteMealPlanEvent>((event, emit) async {
      _logEvent(event);
      emit(MealPlanLoading());
      try {
        await deleteMealPlan.call(event.id);
        _logSuccess('Meal Plan deleted successfully.');

        final updatedMealPlans = await getMealPlan.call(event.date);
        _logSuccess(updatedMealPlans);

        emit(MealPlanSuccess(updatedMealPlans));
      } catch (e) {
        _logError(e);
        emit(MealPlanFailure(e.toString()));
      }
    });

    on<GetMealPlanEvent>((event, emit) async {
      _logEvent(event);
      emit(MealPlanLoading());
      try {
        final result = await getMealPlan.call(event.date);
        _logSuccess(result);
        emit(MealPlanSuccess(result));
      } catch (e) {
        _logError(e);
        emit(MealPlanFailure(e.toString()));
      }
    });
  }

  // Helper methods for logging
  void _logEvent(MealPlanEvent event) {
    print('[MealPlanBloc] Event: $event');
  }

  void _logSuccess(dynamic result) {
    print('[MealPlanBloc] Success: $result');
  }

  void _logError(Object error) {
    print('[MealPlanBloc] Error: $error');
  }
}
