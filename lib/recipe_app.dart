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
