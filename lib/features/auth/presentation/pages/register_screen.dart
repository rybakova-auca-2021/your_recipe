import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:your_recipe/router/app_router.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 32.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SIGN",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 0.11.sh,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "UP",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 0.11.sh,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        isRussian ? messagesRu['one_step_one_way'] ?? '' : messagesEn['one_step_one_way'] ?? '',
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
                isRussian ? messagesRu['email'] ?? '' : messagesEn['email'] ?? '',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 48.h,
                child: TextField(
                  style: const TextStyle(color: AppColors.black),
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: isRussian ? messagesRu['enter_email_hint'] ?? '' : messagesEn['enter_email_hint'] ?? '',
                    hintStyle: const TextStyle(color: AppColors.darkGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                isRussian ? messagesRu['password'] ?? '' : messagesEn['password'] ?? '',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 48.h,
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
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
              ),
              SizedBox(height: 8.h),
              Text(
                isRussian ? messagesRu['password_confirm'] ?? '' : messagesEn['password_confirm'] ?? '',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 48.h,
                child: TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
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
              ),
              SizedBox(height: 23.h),
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
                    final confirmPassword = confirmPasswordController.text;
                    context.read<RegisterBloc>().add(RegisterRequested(email, password, confirmPassword));
                  },
                  child: Text(
                    isRussian ? messagesRu['register'] ?? '' : messagesEn['register'] ?? '',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  isRussian ? messagesRu['or'] ?? '' : messagesEn['or'] ?? '',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
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
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                      ),
                    );
                  } else if (state is RegisterSuccess) {
                    AutoRouter.of(context).push(const MainRoute());
                  } else if (state is RegisterError) {
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
      ),
    );
  }
}
