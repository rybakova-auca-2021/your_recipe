import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

class IngredientDetailsBottomSheet extends StatelessWidget {
  final String title;
  final String manufactureDate;
  final String expirationDate;

  const IngredientDetailsBottomSheet({
    Key? key,
    required this.title,
    required this.manufactureDate,
    required this.expirationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildDetailRow('Date of manufacture', manufactureDate),
            SizedBox(height: 16.h),
            _buildDetailRow('Expiration date', expirationDate),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 18.sp),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            margin: EdgeInsets.all(8.r),
            child: Text(
              value,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
      ],
    );
  }
}
