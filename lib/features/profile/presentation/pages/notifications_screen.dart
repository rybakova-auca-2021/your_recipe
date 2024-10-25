import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isAppNewsEnabled = false;
  bool _isNewRecipesEnabled = false;
  bool _isRemindersEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          "Notifications",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text(
                "Receive App News",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp
                ),
              ),
              value: _isAppNewsEnabled,
              activeTrackColor: Colors.orange,
              onChanged: (bool value) {
                setState(() {
                  _isAppNewsEnabled = value;
                });
              },
            ),
            SizedBox(height: 16.h),
            SwitchListTile(
              title: Text(
                  "New recipes",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp
                  )
              ),
              value: _isNewRecipesEnabled,
              activeTrackColor: Colors.orange,
              onChanged: (bool value) {
                setState(() {
                  _isNewRecipesEnabled = value;
                });
              },
            ),
            SizedBox(height: 16.h),
            SwitchListTile(
              title: Text(
                  "Meal planning reminders",
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp
                  )
              ),
              value: _isRemindersEnabled,
              activeTrackColor: Colors.orange,
              onChanged: (bool value) {
                setState(() {
                  _isRemindersEnabled = value;
                });
              },
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // todo
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
                  'Save',
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
      ),
    );
  }
}
