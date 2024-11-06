import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets/recipe_card.dart';
import '../../../main/domain/usecase/fetch_favorites_use_case.dart';
import '../bloc/fetch_favorite_bloc/fetch_favorite_bloc.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _blocFavorites = FavoritesBloc(
    GetIt.I<FetchFavoritesUseCase>(),
  );

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _blocFavorites.add(FetchFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          "Saved recipes",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocProvider(
          create: (_) => _blocFavorites,
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {

              if (state is FavoritesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FavoritesSuccess) {
                if (state.recipes.isEmpty) {
                  return const Center(
                    child: Text("No favorite recipes found."),
                  );
                }

                return ListView.builder(
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = state.recipes[index];
                    return RecipeCard(
                      imageUrl: recipe.imageUrl,
                      title: recipe.name,
                      prepTime: recipe.time,
                      servings: recipe.numberOfPeople,
                    );
                  },
                );
              } else if (state is FavoritesFailure) {
                return Center(
                  child: Text(
                    "Failed to load favorites: ${state.error}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const Center(child: Text("Unexpected state"));
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _blocFavorites.close();
    super.dispose();
  }
}
