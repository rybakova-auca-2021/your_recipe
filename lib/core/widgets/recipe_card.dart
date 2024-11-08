import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String prepTime;
  final String servings;

  const RecipeCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.prepTime,
    required this.servings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.15.sh,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.lightGrey,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              imageUrl,
              width: 0.45.sw,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 20),
                    SizedBox(width: 4.h),
                    Text(
                      '$prepTime min',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(Icons.person_outlined, size: 20),
                    SizedBox(width: 4.h),
                    Text(
                      '$servings',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
