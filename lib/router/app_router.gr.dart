// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddMealPlanScreen]
class AddMealPlanRoute extends PageRouteInfo<AddMealPlanRouteArgs> {
  AddMealPlanRoute({
    Key? key,
    required String date,
    List<PageRouteInfo>? children,
  }) : super(
          AddMealPlanRoute.name,
          args: AddMealPlanRouteArgs(
            key: key,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMealPlanRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMealPlanRouteArgs>();
      return AddMealPlanScreen(
        key: args.key,
        date: args.date,
      );
    },
  );
}

class AddMealPlanRouteArgs {
  const AddMealPlanRouteArgs({
    this.key,
    required this.date,
  });

  final Key? key;

  final String date;

  @override
  String toString() {
    return 'AddMealPlanRouteArgs{key: $key, date: $date}';
  }
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
/// [CollectionScreen]
class CollectionRoute extends PageRouteInfo<void> {
  const CollectionRoute({List<PageRouteInfo>? children})
      : super(
          CollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CollectionScreen();
    },
  );
}

/// generated route for
/// [DetailCollectionScreen]
class DetailCollectionRoute extends PageRouteInfo<DetailCollectionRouteArgs> {
  DetailCollectionRoute({
    Key? key,
    required int id,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          DetailCollectionRoute.name,
          args: DetailCollectionRouteArgs(
            key: key,
            id: id,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailCollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailCollectionRouteArgs>();
      return DetailCollectionScreen(
        key: args.key,
        id: args.id,
        title: args.title,
      );
    },
  );
}

class DetailCollectionRouteArgs {
  const DetailCollectionRouteArgs({
    this.key,
    required this.id,
    required this.title,
  });

  final Key? key;

  final int id;

  final String title;

  @override
  String toString() {
    return 'DetailCollectionRouteArgs{key: $key, id: $id, title: $title}';
  }
}

/// generated route for
/// [DetailRecipeScreen]
class DetailRecipeRoute extends PageRouteInfo<DetailRecipeRouteArgs> {
  DetailRecipeRoute({
    Key? key,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
          DetailRecipeRoute.name,
          args: DetailRecipeRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRecipeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRecipeRouteArgs>();
      return DetailRecipeScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class DetailRecipeRouteArgs {
  const DetailRecipeRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'DetailRecipeRouteArgs{key: $key, id: $id}';
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
/// [FilterScreen]
class FilterRoute extends PageRouteInfo<void> {
  const FilterRoute({List<PageRouteInfo>? children})
      : super(
          FilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FilterScreen();
    },
  );
}

/// generated route for
/// [FoodPreferenceScreen]
class FoodPreferenceRoute extends PageRouteInfo<void> {
  const FoodPreferenceRoute({List<PageRouteInfo>? children})
      : super(
          FoodPreferenceRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodPreferenceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FoodPreferenceScreen();
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
/// [IngredientsScreen]
class IngredientsRoute extends PageRouteInfo<void> {
  const IngredientsRoute({List<PageRouteInfo>? children})
      : super(
          IngredientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'IngredientsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IngredientsScreen();
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
/// [MealCreationPage]
class MealCreationRoute extends PageRouteInfo<void> {
  const MealCreationRoute({List<PageRouteInfo>? children})
      : super(
          MealCreationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MealCreationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealCreationPage();
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
/// [PopularScreen]
class PopularRoute extends PageRouteInfo<void> {
  const PopularRoute({List<PageRouteInfo>? children})
      : super(
          PopularRoute.name,
          initialChildren: children,
        );

  static const String name = 'PopularRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PopularScreen();
    },
  );
}

/// generated route for
/// [PreferencesScreen]
class PreferencesRoute extends PageRouteInfo<void> {
  const PreferencesRoute({List<PageRouteInfo>? children})
      : super(
          PreferencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'PreferencesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PreferencesScreen();
    },
  );
}

/// generated route for
/// [RecipeFilterScreen]
class RecipeFilterRoute extends PageRouteInfo<RecipeFilterRouteArgs> {
  RecipeFilterRoute({
    Key? key,
    required Map<String, dynamic> filters,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeFilterRoute.name,
          args: RecipeFilterRouteArgs(
            key: key,
            filters: filters,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeFilterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeFilterRouteArgs>();
      return RecipeFilterScreen(
        key: args.key,
        filters: args.filters,
      );
    },
  );
}

class RecipeFilterRouteArgs {
  const RecipeFilterRouteArgs({
    this.key,
    required this.filters,
  });

  final Key? key;

  final Map<String, dynamic> filters;

  @override
  String toString() {
    return 'RecipeFilterRouteArgs{key: $key, filters: $filters}';
  }
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
