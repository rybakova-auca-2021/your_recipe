import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/auth/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:your_recipe/router/app_router.dart';

@RoutePage()
class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 16, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "passw",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "ord",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "Enter the verification\ncode that was sent to\nrybakova_k@auca.kg",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              "New password",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              style: const TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: AppColors.darkGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Confirm new password",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              obscureText: true,
              controller: newPasswordController,
              style: const TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: AppColors.darkGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  context.read<UpdatePasswordBloc>().add(UpdatePasswordRequested(passwordController.text, newPasswordController.text, userId));
                },
                child: Text(
                  "Update your password",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
              listener: (context, state) {
                if (state is UpdatePasswordLoading) {
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  );
                } else if (state is UpdatePasswordSuccess) {
                  AutoRouter.of(context).push(const WelcomeRoute());
                } else if (state is UpdatePasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
