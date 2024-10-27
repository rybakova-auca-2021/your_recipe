import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors.dart';
import '../data/onboard_data.dart';
import 'onboarding_indicators.dart';

class OnboardingPageItem extends StatelessWidget {
  final OnboardingData dataRPBoard;
  final int currentIndex;
  final int itemCount;

  const OnboardingPageItem({
    super.key,
    required this.dataRPBoard,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.50.h;

    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                dataRPBoard.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 34.sp,
                    color: AppColors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 80.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                dataRPBoard.desc,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          OnboardingIndicators(
            currentIndex: currentIndex,
            itemCount: itemCount,
          ),
          SizedBox(height: 37.h),
          Expanded(
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  dataRPBoard.image,
                  fit: BoxFit.cover,
                  height: imageHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
