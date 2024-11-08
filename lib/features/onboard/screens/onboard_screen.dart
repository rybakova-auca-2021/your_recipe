import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/features/onboard/widgets/onboarding_item.dart';
import 'package:your_recipe/router/app_router.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../core/l10n/messages_en.dart';
import '../../../core/l10n/messages_ru.dart';
import '../data/onboard_data.dart';

@RoutePage()
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();
  int introIndex = 0;


  @override
  Widget build(BuildContext context) {
    List<OnboardingData> onboardData = getOnboardingData(context);

    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 36.h),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  introIndex = index;
                });
              },
              itemCount: onboardData.length,
              itemBuilder: (context, index) {
                return OnboardingPageItem(
                  dataRPBoard: onboardData[index],
                  currentIndex: introIndex,
                  itemCount: onboardData.length,
                );
              },
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      height: 46.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (introIndex < onboardData.length - 1) {
                            _controller.animateToPage(
                              introIndex + 1,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            AutoRouter.of(context).push(const WelcomeRoute());
                          }
                        },
                        child: Text(
                          isRussian ? messagesRu['continue'] ?? '' : messagesEn['continue'] ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
