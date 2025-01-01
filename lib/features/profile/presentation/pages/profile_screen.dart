import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_recipe/features/ingredients/presentation/screen/ingredients_screen.dart';
import 'package:your_recipe/features/profile/presentation/widgets/profile_option_row.dart';

import '../../../../core/l10n/language_cubit.dart';
import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';
import '../../../../router/app_router.dart';
import '../bloc/profile_update/profile_bloc.dart';
import '../widgets/language_dropdown.dart';
import '../widgets/profile_detail_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return FutureBuilder<int?>(
      future: _getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange,));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final userId = snapshot.data;
        if (userId == null) {
          return const Center(child: Text('User ID not found'));
        }

        return BlocProvider(
          create: (_) => GetIt.I<ProfileBloc>()..add(FetchProfile(userId)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    AutoRouter.of(context).push(const EditProfileRoute());
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.orange,));
                  } else if (state is ProfileFetchSuccess) {
                    final profile = state.profile;
                    return Column(
                      children: [
                        SizedBox(height: 16.h),
                        CircleAvatar(
                          radius: 50.r,
                          backgroundImage: NetworkImage(profile.profilePhoto),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          profile.username,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            ProfileOptionCard(
                                imagePath: 'https://i.ibb.co/F8WZ292/image.png',
                                label: isRussian ? messagesRu['meal_plan'] ?? '' : messagesEn['meal_plan'] ?? '',
                                onTap: () {
                                  AutoRouter.of(context).push(const MealPlannerRoute());
                                }
                            ),
                            ProfileOptionCard(
                                imagePath: 'https://i.ibb.co/8X2CXgp/image.png',
                                label: isRussian ? messagesRu['your_ingredients'] ?? '' : messagesEn['your_ingredients'] ?? '',
                                onTap: () {
                                  AutoRouter.of(context).push(const IngredientsRoute());
                                }
                            )
                          ],
                        )
                      ],
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
