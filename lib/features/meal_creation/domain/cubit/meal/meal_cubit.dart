import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../repository/meal_repository.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  static final initialState = MealSettingsParameters(
    people: 1,
    maxTimeCooking: 15,
    intoleranceOrLimits: null,
    ingredients: null,
    picture: null,
    type: "ingredients"
  );

  final AbstractMealRepository mealRepository;

  MealCubit(this.mealRepository) : super(initialState);

  void load() {
    emit(initialState);
  }

  void setGenerationType(String type) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters).copyWith(type: type));

        break;
      default:
    }
  }

  void setPeople(int people) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters).copyWith(people: people));

        break;
      default:
    }
  }

  void setMaxTimeCooking(int maxTimeCooking) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters).copyWith(maxTimeCooking: maxTimeCooking));
        break;
      default:
    }
  }

  // set intolerances
  void setIntolerances(String intolerances) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters)
            .copyWith(intoleranceOrLimits: intolerances.isEmpty ? null : intolerances));

        break;
      default:
    }
  }


  // set ingredients
  void setIngredients(String ingredients) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters)
            .copyWith(ingredients: ingredients.isEmpty ? null : ingredients));
        break;
      default:
    }
  }

  // set picture
  void setPicture(XFile? image) {
    switch (state) {
      case MealSettingsParameters():
        emit((state as MealSettingsParameters).copyWith(picture: image));

        break;
      default:
    }
  }

  void getMeal() async {
    switch (state) {
      case MealSettingsParameters():
        final mealParameters = state as MealSettingsParameters;
        if (!mealParameters.isReadyToGenerate()) {
          emit(ErrorState("Please provide at least one ingredient or a picture."));
          return;
        }
        try {
          emit(MealLoading());
          final meals = await mealRepository.getMeals(mealParameters);
          emit(MealLoaded(meals: meals));
        } catch (e) {
          emit(ErrorState(e));
        }
        break;
      default:
    }
  }
}
