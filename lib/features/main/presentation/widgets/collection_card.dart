import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

class CollectionCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CollectionCard({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.lightGrey,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              imageUrl,
              width: 0.9.sw,
              height: 150.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
