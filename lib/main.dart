import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';
import 'package:your_recipe/features/grocery/data/datasources/grocery_remote_data_source.dart';
import 'package:your_recipe/features/grocery/domain/repository/grocery_repository.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_all_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/edit_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/view_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/edit_grocery/edit_grocery_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/view_all_groceries/view_all_groceries_bloc.dart';
import 'package:your_recipe/features/ingredients/data/datasource/ingredient_remote_data_source.dart';
import 'package:your_recipe/features/ingredients/domain/repository/ingredient_repository.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/add_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_all_ingredients_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/delete_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/edit_ingredient_usecase.dart';
import 'package:your_recipe/features/ingredients/domain/usecase/view_ingredients_usecase.dart';
import 'package:your_recipe/features/main/data/datasource/recipe_remote_data_source.dart';
import 'package:your_recipe/features/main/data/repository/recipe_repository_impl.dart';
import 'package:your_recipe/features/main/domain/repository/recipe_repository.dart';
import 'package:your_recipe/features/main/domain/usecase/view_collections_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_filtered_recipes_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_popular_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipe_detail_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipes_in_collection_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_searched_recipes_use_case.dart';
import 'package:your_recipe/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:your_recipe/features/profile/data/repository/profile_repository.dart';
import 'package:your_recipe/features/profile/domain/repositories/profile_repository.dart';
import 'package:your_recipe/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:your_recipe/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:your_recipe/recipe_app.dart';

import 'features/auth/data/datasources/auth_remote_datasources.dart';
import 'features/auth/data/repository/repository.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/reset_password_usecase.dart';
import 'features/auth/domain/usecases/send_code_usecase.dart';
import 'features/auth/domain/usecases/set_password_usecase.dart';
import 'features/grocery/data/repository/grocery_repository_impl.dart';
import 'features/ingredients/data/repository/ingredient_repository_impl.dart';
import 'features/ingredients/presentation/bloc/view_all_groceries/view_all_ingredients_bloc.dart';
import 'features/profile/presentation/bloc/profile_update/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      maxHistoryItems: 30,
      titles: {TalkerLogType.exception: 'Error: '},
      enabled: true,
    ),
  );

  GetIt.I.registerSingleton(talker);
  final talkerDioLogger = TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printResponseHeaders: false,
      printResponseData: false,
    ),
  );

  final Dio dio = Dio();
  dio.interceptors.add(talkerDioLogger);

  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton(sharedPreferences);
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

  GetIt.I.registerLazySingleton<LoginUseCase>(() => LoginUseCase(GetIt.I<AuthRepository>()));
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

  GetIt.I.registerLazySingleton<ViewIngredientsUseCase>(() => ViewIngredientsUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<EditIngredientUseCase>(() => EditIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<AddIngredientUseCase>(() => AddIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<DeleteIngredientUseCase>(() => DeleteIngredientUseCase(GetIt.I<IngredientRepository>()));
  GetIt.I.registerLazySingleton<DeleteAllIngredientsUseCase>(() => DeleteAllIngredientsUseCase(GetIt.I<IngredientRepository>()));


  GetIt.I.registerFactory<ProfileBloc>(() => ProfileBloc(GetIt.I<FetchProfileUsecase>()));
  GetIt.I.registerFactory<ViewAllGroceriesBloc>(() => ViewAllGroceriesBloc(GetIt.I<ViewGroceriesUsecase>()));
  GetIt.I.registerFactory<EditGroceryBloc>(() => EditGroceryBloc(GetIt.I<EditGroceryUsecase>(), GetIt.I<ViewAllGroceriesBloc>()));
  GetIt.I.registerFactory<ViewAllIngredientsBloc>(() => ViewAllIngredientsBloc(GetIt.I<ViewIngredientsUseCase>()));


  GetIt.I.registerLazySingleton<ViewPopularUseCase>(() => ViewPopularUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewCollectionsUseCase>(() => ViewCollectionsUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewFilteredRecipesUseCase>(() => ViewFilteredRecipesUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewRecipeDetailUseCase>(() => ViewRecipeDetailUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewSearchedRecipesUseCase>(() => ViewSearchedRecipesUseCase(GetIt.I<RecipeRepository>()));
  GetIt.I.registerLazySingleton<ViewRecipesInCollectionUseCase>(() => ViewRecipesInCollectionUseCase(GetIt.I<RecipeRepository>()));

  runApp(const RecipeApp());
}
