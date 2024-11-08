import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';
import '../../../../router/app_router.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return Scaffold(
      backgroundColor: Colors.white,
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
                  "WEL",
                  style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 0.15.sh,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "COM",
                  style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 0.15.sh,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "E",
                      style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 0.15.sh,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      isRussian
                          ? messagesRu['welcome_msg'] ?? 'Добрая еда — это основа\nистинного счастья.\nДавайте\nсоздадим что-то вкусное\nвместе!'
                          : messagesEn['welcome_msg'] ?? 'Good food is the foundation\nof genuine happiness.\nLet\'s\ncreate something delicious\ntogether!',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const LoginRoute());
              },
              child: Text(
                isRussian ? messagesRu['login'] ?? 'Вход' : messagesEn['login'] ?? 'Login',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2.0,
                  height: 1.5,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const RegisterRoute());
              },
              child: Text(
                isRussian ? messagesRu['register'] ?? 'Регистрация' : messagesEn['register'] ?? 'Register',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2.0,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
