import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/router/app_router.dart';

import '../../../../../../core/colors.dart';
import '../../../../../../core/widgets/recipe_card.dart';
import '../../domain/usecase/view_popular_use_case.dart';
import '../bloc/popular_recipes_bloc/popular_recipes_bloc.dart';

@RoutePage()
class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>
    with SingleTickerProviderStateMixin {
  late final PopularRecipesBloc _blocAllPopularRecipes;

  @override
  void initState() {
    super.initState();
    _blocAllPopularRecipes = PopularRecipesBloc(
      GetIt.I<ViewPopularUseCase>(),
    );
    _blocAllPopularRecipes.add(const FetchPopularRecipesEvent('today'));
  }

  @override
  void dispose() {
    _blocAllPopularRecipes.close();
    super.dispose();
  }

  void _onTabChanged(int index) {
    final period = index == 0 ? 'today' : index == 1 ? 'week' : 'month';
    _blocAllPopularRecipes.add(FetchPopularRecipesEvent(period));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Most popular",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: TabBar(
            labelColor: AppColors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            dividerColor: Colors.white,
            tabs: const [
              Tab(text: "Today"),
              Tab(text: "This Week"),
              Tab(text: "This Month"),
            ],
            onTap: _onTabChanged,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: BlocBuilder<PopularRecipesBloc, PopularRecipesState>(
            bloc: _blocAllPopularRecipes,
            builder: (context, state) {
              if (state is PopularRecipesLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.orange,));
              } else if (state is PopularRecipesLoaded) {
                final recipes = state.recipes;
                return ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(DetailRecipeRoute(id: recipe.id));
                      },
                      child: RecipeCard(
                        imageUrl: recipe.imageUrl,
                        title: recipe.name,
                        prepTime: recipe.time,
                        servings: recipe.numberOfPeople,
                      ),
                    );
                  },
                );
              } else if (state is PopularRecipesError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Select a tab to view recipes.'));
            },
          ),
        ),
      ),
    );
  }
}
