// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddMealPlanScreen]
class AddMealPlanRoute extends PageRouteInfo<void> {
  const AddMealPlanRoute({List<PageRouteInfo>? children})
      : super(
          AddMealPlanRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMealPlanRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddMealPlanScreen();
    },
  );
}

/// generated route for
/// [BottomNavPage]
class BottomNavRoute extends PageRouteInfo<BottomNavRouteArgs> {
  BottomNavRoute({
    Key? key,
    int indexScr = 0,
    List<PageRouteInfo>? children,
  }) : super(
          BottomNavRoute.name,
          args: BottomNavRouteArgs(
            key: key,
            indexScr: indexScr,
          ),
          initialChildren: children,
        );

  static const String name = 'BottomNavRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BottomNavRouteArgs>(
          orElse: () => const BottomNavRouteArgs());
      return BottomNavPage(
        key: args.key,
        indexScr: args.indexScr,
      );
    },
  );
}

class BottomNavRouteArgs {
  const BottomNavRouteArgs({
    this.key,
    this.indexScr = 0,
  });

  final Key? key;

  final int indexScr;

  @override
  String toString() {
    return 'BottomNavRouteArgs{key: $key, indexScr: $indexScr}';
  }
}

/// generated route for
/// [CodeVerificationScreen]
class CodeVerificationRoute extends PageRouteInfo<CodeVerificationRouteArgs> {
  CodeVerificationRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
          CodeVerificationRoute.name,
          args: CodeVerificationRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'CodeVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CodeVerificationRouteArgs>();
      return CodeVerificationScreen(
        key: args.key,
        userId: args.userId,
      );
    },
  );
}

class CodeVerificationRouteArgs {
  const CodeVerificationRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'CodeVerificationRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfileScreen();
    },
  );
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesScreen();
    },
  );
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [GroceryScreen]
class GroceryRoute extends PageRouteInfo<void> {
  const GroceryRoute({List<PageRouteInfo>? children})
      : super(
          GroceryRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroceryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GroceryScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [MealPlannerScreen]
class MealPlannerRoute extends PageRouteInfo<void> {
  const MealPlannerRoute({List<PageRouteInfo>? children})
      : super(
          MealPlannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'MealPlannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealPlannerScreen();
    },
  );
}

/// generated route for
/// [NotificationsScreen]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationsScreen();
    },
  );
}

/// generated route for
/// [OnboardScreen]
class OnboardRoute extends PageRouteInfo<void> {
  const OnboardRoute({List<PageRouteInfo>? children})
      : super(
          OnboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [UpdatePasswordScreen]
class UpdatePasswordRoute extends PageRouteInfo<UpdatePasswordRouteArgs> {
  UpdatePasswordRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
          UpdatePasswordRoute.name,
          args: UpdatePasswordRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdatePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdatePasswordRouteArgs>();
      return UpdatePasswordScreen(
        key: args.key,
        userId: args.userId,
      );
    },
  );
}

class UpdatePasswordRouteArgs {
  const UpdatePasswordRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'UpdatePasswordRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomeScreen();
    },
  );
}
