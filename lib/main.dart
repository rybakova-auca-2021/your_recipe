import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';
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

  GetIt.I.registerLazySingleton<LoginUseCase>(() => LoginUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<SendCodeUseCase>(() => SendCodeUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<SetPasswordUseCase>(() => SetPasswordUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(GetIt.I<ProfileRepository>()));
  GetIt.I.registerLazySingleton<FetchProfileUsecase>(() => FetchProfileUsecase(GetIt.I<ProfileRepository>()));

  GetIt.I.registerFactory<ProfileBloc>(() => ProfileBloc(GetIt.I<FetchProfileUsecase>()));


  runApp(const RecipeApp());
}
