import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';
import '../bloc/login/login_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16, right: 32, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOG",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 0.13.sh,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "IN",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 0.13.sh,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      isRussian ? messagesRu['welcome_message'] ?? '' : messagesEn['welcome_message'] ?? '',
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
            SizedBox(height: 8.h),
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
              controller: emailController,
              style: const TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: isRussian ? messagesRu['email_hint'] ?? '' : messagesEn['email_hint'] ?? '',
                hintStyle: const TextStyle(color: AppColors.darkGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isRussian ? messagesRu['password_label'] ?? '' : messagesEn['password_label'] ?? '',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: isRussian ? messagesRu['password_hint'] ?? '' : messagesEn['password_hint'] ?? '',
                hintStyle: const TextStyle(color: AppColors.darkGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ForgotPasswordRoute());
                },
                child: Text(
                  isRussian ? messagesRu['forgot_password'] ?? '' : messagesEn['forgot_password'] ?? '',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  context.read<LoginBloc>().add(LoginRequested(email, password));
                },
                child: Text(
                  isRussian ? messagesRu['login_button'] ?? '' : messagesEn['login_button'] ?? '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                isRussian ? messagesRu['or'] ?? '' : messagesEn['or'] ?? '',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 46.h,
              child: ElevatedButton.icon(
                icon: Image.asset('assets/images/google.png', height: 24.h),
                label: Text(
                  isRussian ? messagesRu['continue_with_google'] ?? '' : messagesEn['continue_with_google'] ?? '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                ),
                onPressed: () {
                  // Google Login action
                },
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoading) {
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  );
                } else if (state is LoginSuccess) {
                  AutoRouter.of(context).push(BottomNavRoute());
                } else if (state is LoginError) {
                  // Show error message
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
