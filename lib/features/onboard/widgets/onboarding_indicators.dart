import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors.dart';

class OnboardingIndicators extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const OnboardingIndicators({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColors.orange : AppColors.lightGrey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
