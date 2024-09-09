import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/router/app_router.dart';

import 'data/local/pref.dart';
import 'features/save_token_cubit.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  final _appRouter = AppRouter();
  final Pref pref = Pref();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SaveUserTokenCubit(pref: pref),
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
          );
        },
      ),
    );
  }
}
