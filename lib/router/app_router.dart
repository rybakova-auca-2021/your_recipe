import 'package:auto_route/auto_route.dart';

import '../ui/auth/login_screen.dart';
import '../ui/onboard/onboard_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page)
  ];
}
