import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/features/auth/domain/usecases/login_usecase.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';
import 'package:your_recipe/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:your_recipe/features/auth/presentation/bloc/code_verification/code_verification_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_all_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/edit_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/view_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/add_grocery/add_grocery_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/delete_all_groceries/delete_all_groceries_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/delete_grocery/delete_grocery_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/edit_grocery/edit_grocery_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/view_all_groceries/view_all_groceries_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/add_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_all_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/view_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/add_ingredient/add_ingredient_bloc.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/delete_all_groceries/delete_all_ingredients_bloc.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/delete_grocery/delete_ingredient_bloc.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/edit_grocery/edit_ingredient_bloc.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/view_all_groceries/view_all_ingredients_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/view_collections_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_popular_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipe_detail_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_searched_recipes_use_case.dart';
import 'package:your_recipe/features/main/presentation/bloc/collection_bloc/collection_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/detail_recipe_bloc/detail_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/filtered_recipes_bloc/filtered_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/popular_recipes_bloc/popular_recipes_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/searched_recipes_bloc/searched_recipes_bloc.dart';
import 'package:your_recipe/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:your_recipe/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:your_recipe/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:your_recipe/features/profile/presentation/bloc/profile_update/profile_bloc.dart';
import 'package:your_recipe/router/app_router.dart';
import 'core/bloc/save_token_cubit.dart';
import 'core/l10n/app_localizations.dart';
import 'core/l10n/language_cubit.dart';
import 'core/pref.dart';
import 'features/auth/domain/usecases/send_code_usecase.dart';
import 'features/auth/domain/usecases/set_password_usecase.dart';
import 'features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'features/main/domain/usecase/fetch_favorites_use_case.dart';
import 'features/main/domain/usecase/save_recipe_use_case.dart';
import 'features/main/domain/usecase/view_filtered_recipes_use_case.dart';
import 'features/main/presentation/bloc/save_recipe_bloc/save_recipe_bloc.dart';
import 'features/profile/presentation/bloc/fetch_favorite_bloc/fetch_favorite_bloc.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  final _appRouter = AppRouter();
  final Pref pref = Pref();
  String _languageCode = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _languageCode = prefs.getString('languageCode') ?? 'en'; // Default to English
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit()..changeLanguage(_languageCode),
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, languageCode) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SaveUserTokenCubit(pref: pref),
              ),
              BlocProvider(
                create: (context) => LoginBloc(
                  GetIt.I<LoginUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => RegisterBloc(
                  GetIt.I<RegisterUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => ResetPasswordBloc(
                  GetIt.I<ResetPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => CodeVerificationBloc(
                  GetIt.I<SendCodeUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => UpdatePasswordBloc(
                  GetIt.I<SetPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => ProfileBloc(
                  GetIt.I<FetchProfileUsecase>(),
                ),
              ),
              BlocProvider(
                create: (context) => ProfileUpdateBloc(
                  GetIt.I<UpdateProfileUseCase>(),
                ),
              ),
              BlocProvider<ViewAllGroceriesBloc>(
                create: (context) => ViewAllGroceriesBloc(
                  GetIt.I<ViewGroceriesUsecase>(),
                ),
              ),
              BlocProvider<AddGroceryBloc>(
                create: (context) => AddGroceryBloc(
                  GetIt.I<AddGroceryUsecase>(),
                  GetIt.I<ViewAllGroceriesBloc>(),
                ),
              ),
              BlocProvider(
                create: (context) => EditGroceryBloc(
                  GetIt.I<EditGroceryUsecase>(),
                  GetIt.I<ViewAllGroceriesBloc>(),
                ),
              ),
              BlocProvider<DeleteGroceryBloc>(
                create: (context) => DeleteGroceryBloc(
                  GetIt.I<DeleteGroceryUsecase>(),
                  GetIt.I<ViewAllGroceriesBloc>(),
                ),
              ),
              BlocProvider<DeleteAllGroceriesBloc>(
                create: (context) => DeleteAllGroceriesBloc(
                  GetIt.I<DeleteAllGroceriesUsecase>(),
                  GetIt.I<ViewAllGroceriesBloc>(),
                ),
              ),
              BlocProvider<ViewAllIngredientsBloc>(
                create: (context) => ViewAllIngredientsBloc(
                  GetIt.I<ViewIngredientsUseCase>(),
                ),
              ),
              BlocProvider<AddIngredientBloc>(
                create: (context) => AddIngredientBloc(
                  GetIt.I<AddIngredientUseCase>(),
                  GetIt.I<ViewAllIngredientsBloc>(),
                ),
              ),
              BlocProvider(
                create: (context) => EditIngredientBloc(
                  GetIt.I<EditIngredientUseCase>(),
                  GetIt.I<ViewAllIngredientsBloc>(),
                ),
              ),
              BlocProvider<DeleteIngredientBloc>(
                create: (context) => DeleteIngredientBloc(
                  GetIt.I<DeleteIngredientUseCase>(),
                  GetIt.I<ViewAllIngredientsBloc>(),
                ),
              ),
              BlocProvider<DeleteAllIngredientsBloc>(
                create: (context) => DeleteAllIngredientsBloc(
                  GetIt.I<DeleteAllIngredientsUseCase>(),
                  GetIt.I<ViewAllIngredientsBloc>(),
                ),
              ),
              BlocProvider<CollectionsBloc>(
                create: (context) => CollectionsBloc(
                  GetIt.I<ViewCollectionsUseCase>(),
                ),
              ),
              BlocProvider<DetailRecipeBloc>(
                create: (context) => DetailRecipeBloc(
                  GetIt.I<ViewRecipeDetailUseCase>(),
                ),
              ),
              BlocProvider<FilteredRecipesBloc>(
                create: (context) => FilteredRecipesBloc(
                  GetIt.I<ViewFilteredRecipesUseCase>(),
                ),
              ),
              BlocProvider<PopularRecipesBloc>(
                create: (context) => PopularRecipesBloc(
                  GetIt.I<ViewPopularUseCase>(),
                ),
              ),
              BlocProvider<SearchedRecipesBloc>(
                create: (context) => SearchedRecipesBloc(
                  GetIt.I<ViewSearchedRecipesUseCase>(),
                ),
              ),
              BlocProvider<FavoritesBloc>(
                create: (context) => FavoritesBloc(
                  GetIt.I<FetchFavoritesUseCase>(),
                ),
              ),
              BlocProvider<RecipeFavoriteBloc>(
                create: (context) => RecipeFavoriteBloc(
                  GetIt.I<SaveRecipeUseCase>(),
                ),
              ),
            ],
            child: ScreenUtilInit(
              builder: (context, child) {
                return MaterialApp.router(
                  routerConfig: _appRouter.config(
                    navigatorObservers: () => [
                      TalkerRouteObserver(GetIt.I<Talker>()),
                    ],
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''),
                    Locale('ru', ''),
                  ],
                  locale: Locale(languageCode),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
