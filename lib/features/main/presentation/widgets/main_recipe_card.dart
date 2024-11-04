import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

class MainRecipeCard extends StatelessWidget {
  final String title;
  final String time;
  final String servings;
  final String imageUrl;

  const MainRecipeCard({
    required this.title,
    required this.time,
    required this.servings,
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitWidth,
                width: 270.w,
                height: 150.h,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style:  TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
