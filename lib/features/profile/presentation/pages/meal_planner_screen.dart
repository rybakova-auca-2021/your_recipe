import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/router/app_router.dart';

@RoutePage()
class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  late final DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
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
            const Spacer(),
            Column(
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
                      AutoRouter.of(context).push(const AddMealPlanRoute());
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
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
