import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/cubit/meal/meal_cubit.dart';

class FormByPictureCreation extends StatelessWidget {
  final MealSettingsParameters state;

  FormByPictureCreation({required this.state, super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    context.read<MealCubit>().setGenerationType("image");
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add a picture of a food you want to generate recipe for",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.photo_size_select_actual_rounded),
                  onPressed: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      context.read<MealCubit>().setPicture(image);
                    }
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
                    if (image != null) {
                      context.read<MealCubit>().setPicture(image);
                    }
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
            SizedBox(height: 16.h),
            BlocBuilder<MealCubit, MealState>(
              builder: (context, state) {
                if (state is MealSettingsParameters) {
                  return state.picture != null
                      ? Image.file(
                    File(state.picture!.path),
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: Text(
                        "No image selected",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              icon: Icon(Icons.set_meal_rounded, color: Theme.of(context).colorScheme.onPrimary),
              onPressed: state.isReadyToGenerate() ? () => context.read<MealCubit>().getMeal() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50.h),
              ),
              label: Text(
                "Create recipe",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
