import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/router/app_router.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';
import '../bloc/reset_password/reset_password_bloc.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

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
                      isRussian ? messagesRu['email_instruction'] ?? '' : messagesEn['email_instruction'] ?? '',
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
            SizedBox(height: 20.h),
            Text(
              isRussian ? messagesRu['email_label'] ?? '' : messagesEn['email_label'] ?? '',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              style: const TextStyle(color: AppColors.black),
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText:  isRussian ? messagesRu['email_hint'] ?? '' : messagesEn['email_hint'] ?? '',
                hintStyle: const TextStyle(color: AppColors.darkGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 40.h),
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
                  final email = emailController.text;
                  context.read<ResetPasswordBloc>().add(SendCodeRequested(email));
                },
                child: Text(
                  isRussian ? messagesRu['send_verification_code'] ?? '' : messagesEn['send_verification_code'] ?? '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isRussian ? messagesRu['back_to_login'] ?? '' : messagesEn['back_to_login'] ?? '',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocListener<ResetPasswordBloc, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordLoading) {
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  );
                } else if (state is ResetPasswordSuccess) {
                  AutoRouter.of(context).push(CodeVerificationRoute(userId: state.userId.toString()));
                } else if (state is ResetPasswordError) {
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
