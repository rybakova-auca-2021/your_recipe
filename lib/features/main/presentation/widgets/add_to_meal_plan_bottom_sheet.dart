import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../profile/domain/entities/meal_plan_create_entity.dart';
import '../../../profile/presentation/bloc/meal_plan_bloc/meal_plan_bloc.dart';

class MealPlanBottomSheet extends StatefulWidget {

  final int id;

  const MealPlanBottomSheet({super.key, required this.id});

  @override
  _MealPlanBottomSheetState createState() => _MealPlanBottomSheetState();
}

class _MealPlanBottomSheetState extends State<MealPlanBottomSheet> {
  final TextEditingController _dateController = TextEditingController();
  String _selectedMealType = 'breakfast';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(32.r)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add recipe to your meal plan',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text('You can select date and meal type here', style: TextStyle(color: AppColors.darkGrey, fontSize: 12.sp)),
            SizedBox(height: 20.h),
            ToggleButtons(
              isSelected: ['breakfast', 'lunch', 'dinner'].map((mealType) {
                return _selectedMealType == mealType;
              }).toList(),
              onPressed: (index) {
                setState(() {
                  _selectedMealType = ['breakfast', 'lunch', 'dinner'][index];
                });
              },
              borderRadius: BorderRadius.circular(16),
              selectedColor: Colors.white,
              selectedBorderColor: Colors.orange,
              fillColor: Colors.orange,
              color: Colors.orange,
              borderWidth: 1.5,
              splashColor: Colors.orange.withOpacity(0.3),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(child: Text('Breakfast')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(child: Text('Lunch')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(child: Text('Dinner')),
                ),
              ],  // Splash color effect
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_month_outlined, color: AppColors.darkGrey,),
                labelText: 'Date',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _dateController.text = picked.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white
                ),
                onPressed: () {
                  final selectedDate = _dateController.text;
                  final selectedMealType = _selectedMealType;
                  final mealPlan = MealPlanCreateEntity(
                    date: selectedDate,
                    mealType: selectedMealType,
                    recipe: widget.id
                  );
                  context.read<MealPlanBloc>().add(AddMealPlanEvent(mealPlan));
                  Navigator.pop(context);
                },
                child: const Text('Add to Meal Plan'),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
