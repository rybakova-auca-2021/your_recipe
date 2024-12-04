import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/features/profile/presentation/bloc/meal_plan_bloc/meal_plan_bloc.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets/recipe_card.dart';
import '../../../main/domain/usecase/fetch_recipes_by_category_use_case.dart';
import '../../domain/entities/meal_plan_create_entity.dart';
import '../bloc/category_recipes_bloc/category_recipes_bloc.dart';

@RoutePage()
class AddMealPlanScreen extends StatefulWidget {
  const AddMealPlanScreen({super.key, required this.date});
  final String date;

  @override
  State<AddMealPlanScreen> createState() => _AddMealPlanScreenState();
}

class _AddMealPlanScreenState extends State<AddMealPlanScreen> with SingleTickerProviderStateMixin {
  final _blocMealPlan = CategoryRecipesBloc(GetIt.I<FetchRecipesByCategoryUseCase>());
  String selectedCategory = 'breakfast';
  int selectedRecipeIndex = -1;
  late TabController _tabController;

  final Map<String, MealPlanCreateEntity?> selectedRecipes = {
    'breakfast': null,
    'lunch': null,
    'dinner': null,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadMealPlan(selectedCategory);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      String newCategory = '';
      switch (_tabController.index) {
        case 0:
          newCategory = 'breakfast';
          break;
        case 1:
          newCategory = 'lunch';
          break;
        case 2:
          newCategory = 'dinner';
          break;
      }
      if (newCategory != selectedCategory) {
        setState(() {
          selectedCategory = newCategory;
        });
        _loadMealPlan(newCategory);
      }
    }
  }

  Future<void> _loadMealPlan(String category) async {
    _blocMealPlan.add(FetchCategoryRecipesEvent(category));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            "Add a Meal Plan",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.orange,
            labelStyle: TextStyle(
              fontSize: 16.sp,
            ),
            unselectedLabelColor: Colors.orange,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.orange,
            tabs: const [
              Tab(text: "Breakfast"),
              Tab(text: "Lunch"),
              Tab(text: "Dinner"),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent('Breakfast'),
                  _buildTabContent('Lunch'),
                  _buildTabContent('Dinner'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.h, right: 16.w, left: 16.w),
              child: ElevatedButton(
                onPressed: () {
                  List<MealPlanCreateEntity> mealPlans = [];
                  selectedRecipes.forEach((mealType, recipe) {
                    if (recipe != null) {
                      mealPlans.add(recipe);
                    }
                  });

                  if (mealPlans.isNotEmpty) {
                    context.read<MealPlanBloc>().add(
                      AddBulkMealPlansEvent(mealPlans),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recipes added to meal plan')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select recipes for all meals')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  minimumSize: Size(double.infinity, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Add to Meal Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String mealType) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: 'Search $mealType Recipes',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: BlocBuilder<CategoryRecipesBloc, CategoryRecipesState>(
              bloc: _blocMealPlan,
              builder: (context, state) {
                if (state is CategoryRecipesLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orange,));
                } else if (state is CategoryRecipesLoaded) {
                  final recipes = state.recipes;
                  if (recipes.isEmpty) {
                    return Center(
                      child: Text(
                        "No recipes available",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRecipes[mealType] = MealPlanCreateEntity(
                              date: widget.date,
                              mealType: mealType.toLowerCase(),
                              recipe: recipe.id,
                            );
                          });
                        },
                        child: RecipeCard(
                          imageUrl: recipe.imageUrl,
                          title: recipe.name,
                          prepTime: recipe.time.toString(),
                          servings: recipe.numberOfPeople.toString(),
                          borderColor: selectedRecipes[mealType]?.recipe == recipe.id
                              ? AppColors.orange
                              : Colors.grey[100],
                        ),
                      );
                    },
                  );
                } else if (state is CategoryRecipesError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
