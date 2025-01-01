import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/bottom_nav.dart';
import '../features/auth/presentation/pages/code_verification_screen.dart';
import '../features/auth/presentation/pages/forgot_password_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/register_screen.dart';
import '../features/auth/presentation/pages/update_password_screen.dart';
import '../features/auth/presentation/pages/welcome_screen.dart';
import '../features/grocery/presentation/screens/grocery_screen.dart';
import '../features/ingredients/presentation/screen/ingredients_screen.dart';
import '../features/main/presentation/screens/detail_recipe_screen.dart';
import '../features/main/presentation/screens/fliter_screen.dart';
import '../features/main/presentation/screens/main_screen.dart';
import '../features/main/presentation/screens/popular_screen.dart';
import '../features/main/presentation/screens/collection_screen.dart';
import '../features/main/presentation/screens/recipe_filter_screen.dart';
import '../features/main/presentation/screens/detail_collection_screen.dart';
import '../features/meal_creation/presentation/meal_creation_page.dart';
import '../features/onboard/screens/onboard_screen.dart';
import '../features/preferences/presentation/pages/food_preference_screen.dart';
import '../features/preferences/presentation/pages/preferences_screen.dart';
import '../features/profile/presentation/pages/add_meal_plan_screen.dart';
import '../features/profile/presentation/pages/edit_profile_screen.dart';
import '../features/profile/presentation/pages/favorites_screen.dart';
import '../features/profile/presentation/pages/meal_planner_screen.dart';
import '../features/profile/presentation/pages/notifications_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardRoute.page, initial: true, guards: [AuthGuard()]),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: CodeVerificationRoute.page),
    AutoRoute(page: UpdatePasswordRoute.page),
    AutoRoute(page: PreferencesRoute.page),
    AutoRoute(page: FoodPreferenceRoute.page),

    AutoRoute(page: MainRoute.page),
    AutoRoute(page: BottomNavRoute.page),
    AutoRoute(page: NotificationsRoute.page),
    AutoRoute(page: MealPlannerRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: AddMealPlanRoute.page),
    AutoRoute(page: FavoritesRoute.page),
    AutoRoute(page: CollectionRoute.page),
    AutoRoute(page: PopularRoute.page),
    AutoRoute(page: FilterRoute.page),
    AutoRoute(page: RecipeFilterRoute.page),
    AutoRoute(page: DetailCollectionRoute.page),
    AutoRoute(page: DetailRecipeRoute.page),
    AutoRoute(page: MealCreationRoute.page),
    AutoRoute(page: IngredientsRoute.page),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    print(token);

    if (token != null) {
      router.replace(BottomNavRoute());
    } else {
      resolver.next();
    }
  }
}
