import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/router/app_router.dart';

import '../widgets/language_dropdown.dart';
import '../widgets/logout_button.dart';
import '../widgets/profile_detail_field.dart';
import '../widgets/profile_option_row.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications, color: Colors.orange),
          onPressed: () {
            AutoRouter.of(context).push(const NotificationsRoute());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: () {
              AutoRouter.of(context).push(const EditProfileRoute());
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CircleAvatar(
              radius: 50.r,
              backgroundImage: const NetworkImage('https://i.ibb.co/m8CpW33/profile-pic.jpg'),
            ),
            SizedBox(height: 16.h),
            Text(
              "kxmillx",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            const ProfileDetailField(
              label: 'Your Email',
              icon: Icons.email_outlined,
              value: 'xxx@gmail.com',
            ),
            SizedBox(height: 16.h),
            ProfileDropdownField(
              label: 'Language',
              value: 'English',
              onChanged: (newValue) {
                // todo
              },
            ),
            SizedBox(height: 16.h),
            ProfileOptionRow(
              label: 'Meal plan',
              onTap: () {
                AutoRouter.of(context).push(const MealPlannerRoute());
              },
            ),
            ProfileOptionRow(
              label: 'Saved recipes',
              onTap: () {
                AutoRouter.of(context).push(const FavoritesRoute());
              },
            ),
            const Spacer(),
            LogoutButton(onPressed: () {
              // todo
            }),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}




