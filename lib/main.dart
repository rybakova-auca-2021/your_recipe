import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/recipe_app.dart';
import 'package:your_recipe/repository/abstract_repository.dart';
import 'package:your_recipe/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Talker
  final talker = TalkerFlutter.init(
      settings: TalkerSettings(
        maxHistoryItems: 30,
        titles: {TalkerLogType.exception: 'Error: '},
        enabled: false,
      ));
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>();

  final talkerDioLogger = TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseHeaders: false,
        printResponseData: false,
      ));

  ///Dio
  final Dio dio = Dio();
  dio.interceptors.add(talkerDioLogger);

  ///Shared Preferences
  GetIt.I.registerSingleton(await SharedPreferences.getInstance());

  ///Repository
  GetIt.I.registerLazySingleton<AbstractRepository>(() => Repository(dio: dio));

  runApp(const RecipeApp());
}
