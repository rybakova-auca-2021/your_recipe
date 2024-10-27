import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:your_recipe/features/auth/domain/usecases/login_usecase.dart';
import 'package:your_recipe/features/auth/domain/usecases/register_usecase.dart';
import 'package:your_recipe/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:your_recipe/features/auth/presentation/bloc/code_verification/code_verification_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:your_recipe/features/auth/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:your_recipe/router/app_router.dart';

import 'core/bloc/save_token_cubit.dart';
import 'core/pref.dart';
import 'features/auth/domain/usecases/send_code_usecase.dart';
import 'features/auth/domain/usecases/set_password_usecase.dart';
import 'features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';

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
