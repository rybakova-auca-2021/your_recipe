import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/core/widgets/recipe_card.dart';

import '../../../../router/app_router.dart';
import '../../domain/usecase/view_filtered_recipes_use_case.dart';
import '../bloc/filtered_recipes_bloc/filtered_recipe_bloc.dart';

@RoutePage()
class RecipeFilterScreen extends StatefulWidget {
  final Map<String, dynamic> filters;

  const RecipeFilterScreen({super.key, required this.filters});

  @override
  State<RecipeFilterScreen> createState() => _RecipeFilterScreenState();
}

class _RecipeFilterScreenState extends State<RecipeFilterScreen> {
  final _blocFilterRecipes = FilteredRecipesBloc(
    GetIt.I<ViewFilteredRecipesUseCase>(),
  );

  @override
  void initState() {
    super.initState();
    _loadFilterRecipes();
  }

  Map<String, dynamic> _getTransformedFilters() {
    final Map<String, dynamic> transformedFilters = {};

    if (widget.filters['10-25 min'] == true) transformedFilters['time'] = '~10-25';
    if (widget.filters['30-45 min'] == true) transformedFilters['time'] = '~30-45';
    if (widget.filters['under 60 min'] == true) transformedFilters['time'] = '~60';

    if (widget.filters['1-2'] == true) transformedFilters['number_of_people'] = '1-2';
    if (widget.filters['2-4'] == true) transformedFilters['number_of_people'] = '2-4';
    if (widget.filters['6-10'] == true) transformedFilters['number_of_people'] = '6-10';

    if (widget.filters['super easy'] == true) transformedFilters['difficulty'] = 'super easy';
    if (widget.filters['not too tricky'] == true) transformedFilters['difficulty'] = 'not too tricky';
    if (widget.filters['showing off'] == true) transformedFilters['difficulty'] = 'showing off';

    if (widget.filters['vegetarian recipes'] == true) transformedFilters['is_vegetarian'] = true;
    if (widget.filters['gluten-free recipes'] == true) transformedFilters['is_gluten_free'] = true;
    if (widget.filters['budget-friendly recipes'] == true) transformedFilters['is_budget_friendly'] = true;

    return transformedFilters;
  }


  Future<void> _loadFilterRecipes() async {
    final transformedFilters = _getTransformedFilters();
    _blocFilterRecipes.add(FetchFilteredRecipesEvent(transformedFilters));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Recipe Filters', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              children: widget.filters.entries
                  .where((entry) => entry.value == true)
                  .map((entry) => Stack(
                clipBehavior: Clip.none,
                children: [
                  FilterChip(
                    label: Text(
                      entry.key,
                      style: const TextStyle(color: Colors.white),
                    ),
                    selected: entry.value,
                    backgroundColor: Colors.orange,
                    selectedColor: Colors.orange,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    onSelected: (bool selected) {
                      // Update filter selection
                    },
                  ),
                  Positioned(
                    top: -4.0.h,
                    right: -4.0.w,
                    child: GestureDetector(
                      onTap: () {
                        // Remove filter chip
                      },
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: AppColors.lightGrey,
                        child: Icon(Icons.close, color: Colors.black, size: 16.r),
                      ),
                    ),
                  ),
                ],
              ))
                  .toList(),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<FilteredRecipesBloc, FilteredRecipesState>(
                bloc: _blocFilterRecipes,
                builder: (context, state) {
                  if (state is FilteredRecipesLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.orange));
                  } else if (state is FilteredRecipesLoaded) {
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
                  } else {
                    return const Center(child: Text("No recipes found"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
