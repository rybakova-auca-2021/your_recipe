import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/main/domain/usecase/fetch_recipe_of_the_day_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_collections_use_case.dart';
import 'package:your_recipe/features/main/domain/usecase/view_popular_use_case.dart';
import 'package:your_recipe/features/main/presentation/bloc/collection_bloc/collection_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/daily_recipe_bloc/daily_recipe_bloc.dart';
import 'package:your_recipe/features/main/presentation/bloc/popular_recipes_bloc/popular_recipes_bloc.dart';
import 'package:your_recipe/features/main/presentation/widgets/carousel_card.dart';
import 'package:your_recipe/features/main/presentation/widgets/collection_card.dart';
import 'package:your_recipe/router/app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/recipe_card.dart';
import '../../domain/usecase/view_searched_recipes_use_case.dart';
import '../bloc/searched_recipes_bloc/searched_recipes_bloc.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _blocAllCollections = CollectionsBloc(GetIt.I<ViewCollectionsUseCase>());
  final _blocAllPopularRecipes = PopularRecipesBloc(GetIt.I<ViewPopularUseCase>());
  final _searchedRecipesBloc = SearchedRecipesBloc(GetIt.I<ViewSearchedRecipesUseCase>());
  final _dailyRecipesBloc = RecipeOfTheDayBloc(GetIt.I<FetchRecipeOfTheDayUseCase>());
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadCollections();
    _loadPopularRecipes();
    _loadDailyRecipe();
    _searchController.addListener(_onSearchQueryChanged);
  }

  void _onSearchQueryChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _isSearching = true;
      _searchedRecipesBloc.add(FetchSearchedRecipesEvent(query));
    } else {
      _isSearching = false;
    }
    setState(() {});
  }

  Future<void> _loadCollections() async {
    _blocAllCollections.add(FetchCollectionsEvent());
  }

  Future<void> _loadPopularRecipes() async {
    _blocAllPopularRecipes.add(const FetchPopularRecipesEvent('month'));
  }

  Future<void> _loadDailyRecipe() async {
    _dailyRecipesBloc.add(FetchRecipeOfTheDayEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Recipe Search',
          style: TextStyle(color: Colors.orange, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CollectionsBloc, CollectionsState>(
        bloc: _blocAllCollections,
        builder: (context, collectionsState) {
          return BlocBuilder<PopularRecipesBloc, PopularRecipesState>(
            bloc: _blocAllPopularRecipes,
            builder: (context, popularState) {
              return BlocBuilder<RecipeOfTheDayBloc, RecipeOfTheDayState>(
                bloc: _dailyRecipesBloc,
                builder: (context, dailyRecipeState) {
                  final isLoading =
                      collectionsState is CollectionsLoading ||
                          popularState is PopularRecipesLoading ||
                          dailyRecipeState is RecipeOfTheDayLoading;

                  final hasError =
                      collectionsState is CollectionsError ||
                          popularState is PopularRecipesError ||
                          dailyRecipeState is RecipeOfTheDayError;

                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.orange),
                    );
                  }

                  if (hasError) {
                    return Center(
                      child: Text(
                        'Failed to load data. Please try again.',
                        style: TextStyle(color: Colors.red, fontSize: 16.sp),
                      ),
                    );
                  }

                  if (collectionsState is CollectionsLoaded &&
                      popularState is PopularRecipesLoaded &&
                      dailyRecipeState is RecipeOfTheDayLoaded) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.lightGrey,
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search, size: 24.r),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.filter_list),
                                  onPressed: () {
                                    AutoRouter.of(context).push(const FilterRoute());
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            BlocBuilder<SearchedRecipesBloc, SearchedRecipesState>(
                              bloc: _searchedRecipesBloc,
                              builder: (context, searchState) {
                                if (_isSearching) {
                                  if (searchState is SearchedRecipesLoading) {
                                  
                                  } else if (searchState is SearchedRecipesLoaded) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: searchState.recipes.length,
                                      itemBuilder: (context, index) {
                                        final recipe = searchState.recipes[index];
                                        return RecipeCard(
                                          imageUrl: recipe.imageUrl,
                                          title: recipe.name,
                                          prepTime: recipe.time,
                                          servings: recipe.numberOfPeople,
                                        );
                                      },
                                    );
                                  } else if (searchState is SearchedRecipesError) {
                                    return const Center(child: Text('Failed to load search results'));
                                  }
                                }
                                return const SizedBox.shrink();
                              },
                            ),

                            if (!_isSearching) ...[
                              SizedBox(height: 20.h),
                              Center(
                                child: Text(
                                  'Recipe of the day',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).push(DetailRecipeRoute(id: dailyRecipeState.recipe.id));
                                },
                                child: RecipeCard(
                                  imageUrl: dailyRecipeState.recipe.imageUrl,
                                  title: dailyRecipeState.recipe.name,
                                  prepTime: dailyRecipeState.recipe.time,
                                  servings: dailyRecipeState.recipe.numberOfPeople,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Most popular',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      AutoRouter.of(context).push(const PopularRoute());
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ],
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 250.h,
                                  enableInfiniteScroll: true,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.6,
                                ),
                                items: popularState.recipes.map((recipe) {
                                  return GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(context).push(DetailRecipeRoute(id: recipe.id));
                                    },
                                    child: CarouselCard(
                                      title: recipe.name,
                                      time: recipe.time,
                                      servings: recipe.numberOfPeople,
                                      imageUrl: recipe.imageUrl,
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 16.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Curated Collections',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      AutoRouter.of(context).push(const CollectionRoute());
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              SizedBox(
                                height: 220.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: collectionsState.collections.map((collection) {
                                    return GestureDetector(
                                      onTap: () {
                                        AutoRouter.of(context).push(
                                          DetailCollectionRoute(
                                            id: collection.id,
                                            title: collection.title,
                                          ),
                                        );
                                      },
                                      child: CollectionCard(
                                        title: collection.title,
                                        imageUrl: collection.imageUrl,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _blocAllCollections.close();
    _blocAllPopularRecipes.close();
    _searchedRecipesBloc.close();
    super.dispose();
  }
}


