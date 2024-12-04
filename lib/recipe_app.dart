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
import 'package:your_recipe/features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/add_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_all_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/view_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/ingredient_bloc/ingredient_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/fetch_recipe_of_the_day_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_collections_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_popular_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipe_detail_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_searched_recipes_use_case.dart';
import 'package:your_recipe/features/main/presentation/bloc/collection_bloc/collection_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/daily_recipe_bloc/daily_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/detail_recipe_bloc/detail_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/filtered_recipes_bloc/filtered_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/popular_recipes_bloc/popular_recipes_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/recipe_by_category_bloc/recipe_by_category_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/searched_recipes_bloc/searched_recipes_bloc.dart';
import 'package:your_recipe/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:your_recipe/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:your_recipe/features/profile/presentation/bloc/meal_plan_bloc/meal_plan_bloc.dart';
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
import 'features/grocery/domain/usecase/add_groceries_use_case.dart';
import 'features/main/domain/usecase/fetch_favorites_use_case.dart';
import 'features/main/domain/usecase/fetch_recipes_by_category_use_case.dart';
import 'features/main/domain/usecase/save_recipe_use_case.dart';
import 'features/main/domain/usecase/view_filtered_recipes_use_case.dart';
import 'features/main/presentation/bloc/save_recipe_bloc/save_recipe_bloc.dart';
import 'features/preferences/domain/usecases/add_preferred_cuisine_use_case.dart';
import 'features/preferences/domain/usecases/add_preferred_food_use_case.dart';
import 'features/preferences/domain/usecases/fetch_cuisine_use_case.dart';
import 'features/preferences/domain/usecases/fetch_food_use_case.dart';
import 'features/preferences/domain/usecases/get_preferred_cuisine_use_case.dart';
import 'features/preferences/domain/usecases/get_preferred_food_use_case.dart';
import 'features/preferences/presentation/bloc/add_cuisine_bloc/add_cuisine_bloc.dart';
import 'features/preferences/presentation/bloc/add_food_bloc/add_food_bloc.dart';
import 'features/preferences/presentation/bloc/fetch_cuisine_bloc/fetch_cuisine_bloc.dart';
import 'features/preferences/presentation/bloc/fetch_food_bloc/fetch_food_bloc.dart';
import 'features/preferences/presentation/bloc/get_preferred_cuisine_bloc/get_preferred_cuisine_bloc.dart';
import 'features/preferences/presentation/bloc/get_preferred_food_bloc/get_preferred_food_bloc.dart';
import 'features/profile/domain/usecases/meal_plan_use_case.dart';
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
              BlocProvider<GroceryBloc>(
                create: (context) => GroceryBloc(
                  viewUsecase: GetIt.I<ViewGroceriesUsecase>(),
                  addUsecase: GetIt.I<AddGroceryUsecase>(),
                  addMultipleUsecase: GetIt.I<AddGroceriesUseCase>(),
                  deleteAllUsecase: GetIt.I<DeleteAllGroceriesUsecase>(),
                  deleteUsecase: GetIt.I<DeleteGroceryUsecase>(),
                  editUsecase: GetIt.I<EditGroceryUsecase>(),
                ),
              ),
              BlocProvider<IngredientBloc>(
                create: (context) => IngredientBloc(
                  addUseCase: GetIt.I<AddIngredientUseCase>(),
                  deleteAllUseCase: GetIt.I<DeleteAllIngredientsUseCase>(),
                  deleteUseCase: GetIt.I<DeleteIngredientUseCase>(),
                  editUseCase: GetIt.I<EditIngredientUseCase>(),
                  viewUseCase: GetIt.I<ViewIngredientsUseCase>(),
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
              BlocProvider<RecipeOfTheDayBloc>(
                create: (context) => RecipeOfTheDayBloc(
                  GetIt.I<FetchRecipeOfTheDayUseCase>(),
                ),
              ),
              BlocProvider<AddPreferredCuisineBloc>(
                create: (context) => AddPreferredCuisineBloc(
                  addPreferredCuisineUseCase: GetIt.I<AddPreferredCuisineUseCase>(),
                ),
              ),
              BlocProvider<AddPreferredFoodBloc>(
                create: (context) => AddPreferredFoodBloc(
                  addPreferredFoodUseCase: GetIt.I<AddPreferredFoodUseCase>(),
                ),
              ),
              BlocProvider<FetchCuisineBloc>(
                create: (context) => FetchCuisineBloc(
                  fetchCuisineUseCase: GetIt.I<FetchCuisineUseCase>(),
                ),
              ),
              BlocProvider<FetchFoodBloc>(
                create: (context) => FetchFoodBloc(
                  fetchFoodUseCase: GetIt.I<FetchFoodUseCase>(),
                ),
              ),
              BlocProvider<GetPreferredCuisineBloc>(
                create: (context) => GetPreferredCuisineBloc(
                  getPreferredCuisineUseCase: GetIt.I<GetPreferredCuisineUseCase>(),
                ),
              ),
              BlocProvider<GetPreferredFoodBloc>(
                create: (context) => GetPreferredFoodBloc(
                  getPreferredFoodUseCase: GetIt.I<GetPreferredFoodUseCase>(),
                ),
              ),
              BlocProvider<RecipesByCategoryBloc>(
                create: (context) => RecipesByCategoryBloc(
                  GetIt.I<FetchRecipesByCategoryUseCase>(),
                ),
              ),
              BlocProvider<MealPlanBloc>(
                create: (context) => MealPlanBloc(
                  addBulkMealPlans: GetIt.I<AddBulkMealPlans>(),
                  addMealPlan: GetIt.I<AddMealPlan>(),
                  deleteMealPlan:  GetIt.I<DeleteMealPlan>(),
                  getMealPlan:  GetIt.I<GetMealPlan>(),
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
