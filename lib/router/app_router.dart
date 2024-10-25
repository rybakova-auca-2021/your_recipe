import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import '../core/bottom_nav.dart';
import '../features/auth/presentation/pages/code_verification_screen.dart';
import '../features/auth/presentation/pages/forgot_password_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/register_screen.dart';
import '../features/auth/presentation/pages/update_password_screen.dart';
import '../features/auth/presentation/pages/welcome_screen.dart';
import '../features/grocery/grocery_screen.dart';
import '../features/main/main_screen.dart';
import '../features/onboard/screens/onboard_screen.dart';
import '../features/profile/presentation/pages/add_meal_plan_screen.dart';
import '../features/profile/presentation/pages/edit_profile_screen.dart';
import '../features/profile/presentation/pages/favorites_screen.dart';
import '../features/profile/presentation/pages/meal_planner_screen.dart';
import '../features/profile/presentation/pages/notifications_screen.dart';
import '../features/profile/presentation/pages/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardRoute.page, initial: false),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: CodeVerificationRoute.page),
    AutoRoute(page: UpdatePasswordRoute.page),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: BottomNavRoute.page, initial: true),
    AutoRoute(page: NotificationsRoute.page),
    AutoRoute(page: MealPlannerRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: AddMealPlanRoute.page),
    AutoRoute(page: FavoritesRoute.page),
  ];
}
