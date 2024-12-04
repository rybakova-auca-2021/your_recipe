import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/profile/presentation/bloc/meal_plan_bloc/meal_plan_bloc.dart';
import 'package:your_recipe/router/app_router.dart';
import '../../../../core/widgets/recipe_card.dart';
import '../../domain/usecases/meal_plan_use_case.dart';

@RoutePage()
class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  late DateTime selectedDate;
  final _blocMealPlan = MealPlanBloc(
    addBulkMealPlans: GetIt.I<AddBulkMealPlans>(),
    addMealPlan: GetIt.I<AddMealPlan>(),
    deleteMealPlan: GetIt.I<DeleteMealPlan>(),
    getMealPlan: GetIt.I<GetMealPlan>(),
  );

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _loadMealPlan();
  }

  Future<void> _loadMealPlan() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    _blocMealPlan.add(GetMealPlanEvent(formattedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          "Meal Planner",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            HorizontalWeekCalendar(
              minDate: DateTime(2023, 12, 31),
              maxDate: DateTime(2030, 1, 31),
              initialDate: DateTime.now(),
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                  _loadMealPlan();
                });
              },
              showTopNavbar: false,
              weekStartFrom: WeekStartFrom.Sunday,
              borderRadius: BorderRadius.circular(7),
              activeBackgroundColor: Colors.orange,
              activeTextColor: Colors.white,
              inactiveBackgroundColor: Colors.transparent,
              inactiveTextColor: Colors.black,
              disabledTextColor: Colors.grey,
            ),
            Expanded(
              child: BlocBuilder<MealPlanBloc, MealPlanState>(
                bloc: _blocMealPlan,
                builder: (context, state) {
                  if (state is MealPlanLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.orange));
                  } else if (state is MealPlanSuccess) {
                    final meals = state.data;
                    if (meals.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No data yet",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  AutoRouter.of(context)
                                      .push(AddMealPlanRoute(date: DateFormat('yyyy-MM-dd').format(selectedDate)));
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppColors.orange,
                                  backgroundColor: AppColors.orange,
                                  side: const BorderSide(color: AppColors.orange),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Text(
                                  'Add a Meal Plan',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    Map<String, List> groupedMeals = {};
                    for (var meal in meals) {
                      if (groupedMeals.containsKey(meal.mealType)) {
                        groupedMeals[meal.mealType]?.add(meal);
                      } else {
                        groupedMeals[meal.mealType] = [meal];
                      }
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: groupedMeals.entries
                                  .map((entry) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      child: Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.orange,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: entry.value.map<Widget>((meal) {
                                        return Dismissible(
                                          key: Key(meal.recipe.id.toString()),
                                          direction: DismissDirection.endToStart,
                                          onDismissed: (direction) {
                                            _blocMealPlan.add(DeleteMealPlanEvent(
                                              meal.id,
                                              DateFormat('yyyy-MM-dd').format(selectedDate),
                                            ));
                                          },
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 20.w),
                                            child: Icon(Icons.delete, color: Colors.white),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              AutoRouter.of(context).push(DetailRecipeRoute(id: meal.recipe.id));
                                            },
                                            child: RecipeCard(
                                              imageUrl: meal.recipe.imageUrl,
                                              title: meal.recipe.name,
                                              prepTime: meal.recipe.time.toString(),
                                              servings: meal.recipe.numberOfPeople.toString(),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                );
                              }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              AutoRouter.of(context)
                                  .push(AddMealPlanRoute(date: DateFormat('yyyy-MM-dd').format(selectedDate)));
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.orange,
                              backgroundColor: AppColors.orange,
                              side: const BorderSide(color: AppColors.orange),
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Text(
                              'Add a Meal Plan',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );


                  } else if (state is MealPlanFailure) {
                    return Center(
                      child: Text(
                        "Error loading data: ${state.message}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
