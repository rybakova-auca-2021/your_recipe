import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../../router/app_router.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "WEL",
                  style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 100.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "COM",
                  style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 100.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "E",
                      style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 100.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "Good food is the foundation\nof genuine happiness."
                          "Let's\ncreate something delicious\ntogether!",
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 8.w),
            SizedBox(height: 40.h),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const LoginRoute());
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2.0,
                  height: 1.5,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const RegisterRoute());
              },
              child: Text(
                "Register",
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2.0,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
