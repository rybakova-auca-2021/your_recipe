import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/cubit/meal/meal_cubit.dart';

class FormMealCreation extends StatelessWidget {
  final MealSettingsParameters state;

  FormMealCreation({required this.state, super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    context.read<MealCubit>().setGenerationType("ingredients");
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "How many people are you cooking for?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Slider(
                divisions: 10,
                label: "${state.people} people",
                value: state.people.toDouble(),
                min: 1,
                max: 10,
                activeColor: Colors.orange,
                onChanged: (double value) => context.read<MealCubit>().setPeople(value.toInt()),
              ),
              SizedBox(height: 8.h),
              Text(
                "How long do you want to cook?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              SegmentedButton(
                multiSelectionEnabled: false,
                segments: const [
                  ButtonSegment(label: Text("15 m"), value: 15),
                  ButtonSegment(label: Text("30 m"), value: 30),
                  ButtonSegment(label: Text("45 m"), value: 45),
                  ButtonSegment(label: Text("60 m"), value: 60),
                ],
                selected: {state.maxTimeCooking},
                onSelectionChanged: (selections) => context.read<MealCubit>().setMaxTimeCooking(selections.first),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.orange.shade100;
                      }
                      return Colors.white;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Do you have any preferences? (Optional)",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                onChanged: (String value) => context.read<MealCubit>().setIntolerances(value),
              ),
              SizedBox(height: 16.h),
              Text(
                "Enter your ingredients",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                onChanged: (String value) => context.read<MealCubit>().setIngredients(value),
              ),
              SizedBox(height: 16.h),
              Text(
                "or",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Column(
                children: [
                  Text(
                    'Upload or take an ingredients picture',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.photo_size_select_actual_rounded),
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          context.read<MealCubit>().setPicture(image);
                        },
                        label: Text(
                          "Open Gallery",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.orange.shade100,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.camera_alt_rounded),
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.camera);
                          context.read<MealCubit>().setPicture(image);
                        },
                        label: Text(
                          "Take a Picture",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.orange.shade100,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ElevatedButton.icon(
            icon: Icon(Icons.set_meal_rounded, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: state.isReadyToGenerate() ? () => context.read<MealCubit>().getMeal() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: Size(double.infinity, 50.h),
            ),
            label: Text(
              "Create",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
