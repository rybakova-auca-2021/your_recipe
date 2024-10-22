import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:your_recipe/features/auth/presentation/bloc/code_verification/code_verification_bloc.dart';
import 'package:your_recipe/router/app_router.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';

@RoutePage()
class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    var code;

    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';


    return Scaffold(
      backgroundColor: AppColors.orange,
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
                  "Forgot",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "passw",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "ord",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      isRussian ? messagesRu['verification_instruction'] ?? '' : messagesEn['verification_instruction'] ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Center(
              child: Pinput(
                length: 4,
                showCursor: true,
                onCompleted: (pin) {
                  code = pin;
                },
                defaultPinTheme: PinTheme(
                  width: 40.w,
                  height: 50.h,
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  print("CODE $code");
                  context.read<CodeVerificationBloc>().add(CodeVerificationRequested(code, userId));
                },
                child: Text(
                  isRussian ? messagesRu['reset_password'] ?? '' : messagesEn['reset_password'] ?? '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            BlocListener<CodeVerificationBloc, CodeVerificationState>(
              listener: (context, state) {
                if (state is CodeVerificationLoading) {
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  );
                } else if (state is CodeVerificationSuccess) {
                  AutoRouter.of(context).push(UpdatePasswordRoute(userId: userId));
                } else if (state is CodeVerificationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
