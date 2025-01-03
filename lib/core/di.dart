import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:your_recipe/core/token_interceptor.dart';
import 'package:your_recipe/features/auth/domain/usecases/firebase_auth_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/mark_purchased_usecase.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/ingredient_bloc/ingredient_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/fetch_recipe_of_the_day_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/fetch_recipes_by_category_use_case.dart';
import 'package:your_recipe/features/meal_creation/data/repository/gemini_meal_repository.dart';
import 'package:your_recipe/features/meal_creation/domain/repository/meal_repository.dart';
import 'package:your_recipe/features/preferences/data/datasources/preference_remote_data_source.dart';
import 'package:your_recipe/features/profile/data/datasources/meal_plan_data_source.dart';
import 'package:your_recipe/features/profile/data/repository/plan_repository_impl.dart';
import 'package:your_recipe/features/profile/domain/repositories/meal_plan_repository.dart';
import 'package:your_recipe/features/profile/domain/usecases/meal_plan_use_case.dart';

import '../features/auth/data/datasources/auth_remote_datasources.dart';
import '../features/auth/data/repository/repository.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../features/auth/domain/usecases/reset_password_usecase.dart';
import '../features/auth/domain/usecases/send_code_usecase.dart';
import '../features/auth/domain/usecases/set_password_usecase.dart';
import '../features/grocery/data/datasources/grocery_remote_data_source.dart';
import '../features/grocery/data/repository/grocery_repository_impl.dart';
import '../features/grocery/domain/repository/grocery_repository.dart';
import '../features/grocery/domain/usecase/add_groceries_use_case.dart';
import '../features/grocery/domain/usecase/add_grocery_usecase.dart';
import '../features/grocery/domain/usecase/delete_all_groceries_usecase.dart';
import '../features/grocery/domain/usecase/delete_grocery_usecase.dart';
import '../features/grocery/domain/usecase/edit_grocery_usecase.dart';
import '../features/grocery/domain/usecase/view_groceries_usecase.dart';
import '../features/ingredients/data/datasource/ingredient_remote_data_source.dart';
import '../features/ingredients/data/repository/ingredient_repository_impl.dart';
import '../features/ingredients/domain/repository/ingredient_repository.dart';
import '../features/ingredients/domain/usecase/add_ingredient_usecase.dart';
import '../features/ingredients/domain/usecase/delete_all_ingredients_usecase.dart';
import '../features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import '../features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import '../features/ingredients/domain/usecase/view_ingredients_usecase.dart';
import '../features/main/data/datasource/recipe_remote_data_source.dart';
import '../features/main/data/repository/recipe_repository_impl.dart';
import '../features/main/domain/repository/recipe_repository.dart';
import '../features/main/domain/usecase/fetch_favorites_use_case.dart';
import '../features/main/domain/usecase/save_recipe_use_case.dart';
import '../features/main/domain/usecase/view_collections_use_case.dart';
import '../features/main/domain/usecase/view_filtered_recipes_use_case.dart';
import '../features/main/domain/usecase/view_popular_use_case.dart';
import '../features/main/domain/usecase/view_recipe_detail_use_case.dart';
import '../features/main/domain/usecase/view_recipes_in_collection_use_case.dart';
import '../features/main/domain/usecase/view_searched_recipes_use_case.dart';
import '../features/preferences/data/repository/preference_repository_impl.dart';
import '../features/preferences/domain/repositories/preference_repository.dart';
import '../features/preferences/domain/usecases/add_preferred_cuisine_use_case.dart';
import '../features/preferences/domain/usecases/add_preferred_food_use_case.dart';
import '../features/preferences/domain/usecases/fetch_cuisine_use_case.dart';
import '../features/preferences/domain/usecases/fetch_food_use_case.dart';
import '../features/preferences/domain/usecases/get_preferred_cuisine_use_case.dart';
import '../features/preferences/domain/usecases/get_preferred_food_use_case.dart';
import '../features/profile/data/datasources/profile_remote_data_source.dart';
import '../features/profile/data/repository/profile_repository.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/fetch_profile_usecase.dart';
import '../features/profile/domain/usecases/update_profile_usecase.dart';
import '../features/profile/presentation/bloc/profile_update/profile_bloc.dart';


final getIt = GetIt.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> initDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      maxHistoryItems: 30,
      titles: {TalkerLogType.exception.name: 'Error: '},
      enabled: true,
    ),
  );
  getIt.registerSingleton(talker);

  final dio = Dio();
  dio.interceptors.add(TokenInterceptor(dio));
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseHeaders: false,
        printResponseData: false,
      ),
    ),
  );
  getIt.registerSingleton(dio);

  GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: GetIt.I<AuthRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(remoteDataSource: GetIt.I<ProfileRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<GroceryRemoteDataSource>(
        () => GroceryRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<GroceryRepository>(
        () => GroceryRepositoryImpl(remoteDataSource: GetIt.I<GroceryRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<IngredientRemoteDataSource>(
        () => IngredientRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<IngredientRepository>(
        () => IngredientRepositoryImpl(remoteDataSource: GetIt.I<IngredientRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<RecipeRemoteDataSource>(
        () => RecipeRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<RecipeRepository>(
        () => RecipeRepositoryImpl(remoteDataSource: GetIt.I<RecipeRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<PreferenceRemoteDataSource>(
        () => PreferenceRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<PreferenceRepository>(
        () => PreferenceRepositoryImpl(remoteDataSource: GetIt.I<PreferenceRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<PlanRemoteDataSource>(
        () => PlanRemoteDataSourceImpl(dio: dio),
  );
  GetIt.I.registerLazySingleton<PlanRepository>(
        () => PlanRepositoryImpl(remoteDataSource: GetIt.I<PlanRemoteDataSource>()),
  );

  GetIt.I.registerLazySingleton<AbstractMealRepository>(
        () => GeminiMealRepository(),
  );

  GetIt.I.registerLazySingleton<LoginUseCase>(() => LoginUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<FirebaseAuthUsecase>(() => FirebaseAuthUsecase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<SendCodeUseCase>(() => SendCodeUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<SetPasswordUseCase>(() => SetPasswordUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(GetIt.I<ProfileRepository>()));
  GetIt.I.registerLazySingleton<FetchProfileUsecase>(() => FetchProfileUsecase(GetIt.I<ProfileRepository>()));

  GetIt.I.registerLazySingleton<ViewGroceriesUsecase>(() => ViewGroceriesUsecase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<EditGroceryUsecase>(() => EditGroceryUsecase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<AddGroceryUsecase>(() => AddGroceryUsecase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<DeleteGroceryUsecase>(() => DeleteGroceryUsecase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<DeleteAllGroceriesUsecase>(() => DeleteAllGroceriesUsecase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<AddGroceriesUseCase>(() => AddGroceriesUseCase(GetIt.I<GroceryRepository>()));
  GetIt.I.registerLazySingleton<MarkPurchasedUsecase>(() => MarkPurchasedUsecase(GetIt.I<GroceryRepository>()));

  GetIt.I.registerLazySingleton<ViewIngredientsUseCase>(() => ViewIngredientsUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<EditIngredientUseCase>(() => EditIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<AddIngredientUseCase>(() => AddIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<DeleteIngredientUseCase>(() => DeleteIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<DeleteAllIngredientsUseCase>(() => DeleteAllIngredientsUseCase(GetIt.I<IngredientRepository>()));


  GetIt.I.registerFactory<ProfileBloc>(() => ProfileBloc(GetIt.I<FetchProfileUsecase>()));

  GetIt.I.registerLazySingleton<ViewPopularUseCase>(() => ViewPopularUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewCollectionsUseCase>(() => ViewCollectionsUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewFilteredRecipesUseCase>(() => ViewFilteredRecipesUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewRecipeDetailUseCase>(() => ViewRecipeDetailUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewSearchedRecipesUseCase>(() => ViewSearchedRecipesUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewRecipesInCollectionUseCase>(() => ViewRecipesInCollectionUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<FetchFavoritesUseCase>(() => FetchFavoritesUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<SaveRecipeUseCase>(() => SaveRecipeUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<FetchRecipeOfTheDayUseCase>(() => FetchRecipeOfTheDayUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<FetchRecipesByCategoryUseCase>(() => FetchRecipesByCategoryUseCase(GetIt.I<RecipeRepository>()));

  getIt.registerLazySingleton<AddPreferredCuisineUseCase>(() => AddPreferredCuisineUseCase(repository: GetIt.I<PreferenceRepository>()));
  getIt.registerLazySingleton<AddPreferredFoodUseCase>(() => AddPreferredFoodUseCase(repository: getIt<PreferenceRepository>()));
  getIt.registerLazySingleton<FetchCuisineUseCase>(() => FetchCuisineUseCase(repository: getIt<PreferenceRepository>()),);
  getIt.registerLazySingleton<FetchFoodUseCase>(() => FetchFoodUseCase(repository: getIt<PreferenceRepository>()),);
  getIt.registerLazySingleton<GetPreferredCuisineUseCase>(() => GetPreferredCuisineUseCase(repository: getIt<PreferenceRepository>()),);
  getIt.registerLazySingleton<GetPreferredFoodUseCase>(() => GetPreferredFoodUseCase(repository: getIt<PreferenceRepository>()),);


  getIt.registerLazySingleton<AddBulkMealPlans>(() => AddBulkMealPlans(getIt<PlanRepository>()));
  getIt.registerLazySingleton<AddMealPlan>(() => AddMealPlan(getIt<PlanRepository>()));
  getIt.registerLazySingleton<DeleteMealPlan>(() => DeleteMealPlan(getIt<PlanRepository>()));
  getIt.registerLazySingleton<GetMealPlan>(() => GetMealPlan(getIt<PlanRepository>()));
}
