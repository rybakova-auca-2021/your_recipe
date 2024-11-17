import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipe_detail_use_case.dart';
import 'package:your_recipe/features/main/presentation/bloc/detail_recipe_bloc/detail_recipe_bloc.dart';

import '../../../../generated/assets.dart';
import '../../../grocery/domain/entities/grocery_item_entity.dart';
import '../bloc/save_recipe_bloc/save_recipe_bloc.dart';

@RoutePage()
class DetailRecipeScreen extends StatefulWidget {
  const DetailRecipeScreen({super.key, required this.id});
  final int id;

  @override
  _DetailRecipeScreenState createState() => _DetailRecipeScreenState();
}

class _DetailRecipeScreenState extends State<DetailRecipeScreen> {
  late final DetailRecipeBloc _blocDetailRecipe;

  bool _ingredientsExpanded = false;
  bool _stepsExpanded = false;
  bool _isFavorited = false;
  bool _showButton = true;
  final Set<String> _checkedIngredients = {};

  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _blocDetailRecipe = DetailRecipeBloc(
      GetIt.I<ViewRecipeDetailUseCase>(),
    );
    _loadDetailRecipe();
  }

  Future<void> _loadDetailRecipe() async {
    _blocDetailRecipe.add(FetchRecipeDetailEvent(widget.id));
  }

  @override
  void dispose() {
    _blocDetailRecipe.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: BlocListener<DetailRecipeBloc, DetailRecipeState>(
        bloc: _blocDetailRecipe,
        listener: (context, state) {
          if (state is DetailRecipeLoaded) {
            _isFavorited = state.recipe.isFavorite;
          }
        },
        child: BlocBuilder<DetailRecipeBloc, DetailRecipeState>(
          bloc: _blocDetailRecipe,
          builder: (context, state) {
            if (state is DetailRecipeLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.orange));
            } else if (state is DetailRecipeLoaded) {
              final detailRecipe = state.recipe;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.lightBg,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBar(
                            backgroundColor: AppColors.lightBg,
                            elevation: 0,
                            title: const Text('Recipe', style: TextStyle(color: AppColors.orange)),
                            centerTitle: true,
                            leading: IconButton(
                              icon: const Icon(Icons.arrow_back, color: AppColors.orange),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            actions: [
                              IconButton(
                                icon: const Icon(Icons.share, color: AppColors.orange),
                                onPressed: () {
                                  Share.share('Check out this recipe: Placeholder Recipe');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                                  color: _isFavorited ? Colors.red : Colors.orange,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isFavorited = !_isFavorited;
                                  });
                                  context.read<RecipeFavoriteBloc>().add(
                                    SaveRecipeEvent(detailRecipe.id),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 300.h,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: CachedNetworkImage(
                                imageUrl: detailRecipe.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey.shade500,
                                  highlightColor: Colors.grey.shade200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            )
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            detailRecipe.name,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            detailRecipe.shortDesc,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16.r),
                              SizedBox(width: 4.w),
                              Text("${detailRecipe.time} min"),
                              SizedBox(width: 16.w),
                              SvgPicture.asset(Assets.iconsStarFour),
                              SizedBox(width: 4.w),
                              Text(detailRecipe.difficulty),
                              SizedBox(width: 16.w),
                              SvgPicture.asset(Assets.iconsPerson),
                              SizedBox(width: 4.w),
                              Text('${detailRecipe.numberOfPeople} servings'),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildCircularIndicator(
                                percent: detailRecipe.protein / 100,
                                value: '${(detailRecipe.protein).toStringAsFixed(1)}g',
                                label: 'Protein',
                              ),
                              SizedBox(width: 24.w),
                              buildCircularIndicator(
                                percent: detailRecipe.carbs / 100,
                                value: '${(detailRecipe.carbs).toStringAsFixed(1)}g',
                                label: 'Carbs',
                              ),
                              SizedBox(width: 24.w),
                              buildCircularIndicator(
                                percent: detailRecipe.fat / 100,
                                value: '${(detailRecipe.fat).toStringAsFixed(1)}g',
                                label: 'Fat',
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _ingredientsExpanded ? Icons.expand_less : Icons.expand_more,
                                  color: AppColors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _ingredientsExpanded = !_ingredientsExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                          ..._buildIngredientList(detailRecipe.ingredients),
                          SizedBox(height: 16.h),
                          Visibility(
                            visible: _showButton,
                            child: SizedBox(
                              height: 46.h,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    side: const BorderSide(color: AppColors.orange),
                                  ),
                                  backgroundColor: AppColors.lightBg,
                                ),
                                onPressed: () {
                                  setState(() {
                                    final groceryItems = _checkedIngredients
                                        .map((ingredient) {
                                      final parsed = _parseIngredient(ingredient);
                                      if (parsed != null) {
                                        return GroceryItemEntity(
                                          name: parsed['name']!,
                                          quantity: parsed['quantity']!,
                                        );
                                      }
                                      return null;
                                    })
                                        .whereType<GroceryItemEntity>()
                                        .toList();
                                    context.read<GroceryBloc>().add(GroceriesAdded(groceryItems));
                                  });
                                },
                                label: const Text(
                                  'Add to Grocery List',
                                  style: TextStyle(color: AppColors.orange),
                                ),
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Steps',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Montserrat'
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _stepsExpanded ? Icons.expand_less : Icons.expand_more,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _stepsExpanded = !_stepsExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                          ..._buildStepsList(detailRecipe.steps),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if(state is DetailRecipeError) {
              return Center(
                child: Text('Error: ${state.message}',),
              );
            }
            return const Center(child: Text('Detail recipe is not available.'));
          },
        ),
      ),
    );
  }

  List<Widget> _buildIngredientList(String ingredients) {
    List<String> ingredientList = ingredients.split('\r\n');

    return ingredientList.asMap().entries.map((entry) {
      int index = entry.key;
      String ingredient = entry.value;

      return Visibility(
        visible: _ingredientsExpanded || index < 3,
        child: Row(
          children: [
            Checkbox(
              activeColor: AppColors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              value: _checkedIngredients.contains(ingredient),
              onChanged: (bool? isChecked) {
                setState(() {
                  if (isChecked == true) {
                    _checkedIngredients.add(ingredient);
                  } else {
                    _checkedIngredients.remove(ingredient);
                  }
                });
              },
            ),
            Expanded(
              child: Text(
                ingredient,
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Map<String, String>? _parseIngredient(String ingredient) {
    final match = RegExp(r'^(\d+)\s*(.*)').firstMatch(ingredient);
    if (match != null) {
      return {
        'quantity': match.group(1) ?? '',
        'name': match.group(2) ?? ''
      };
    }
    return null;
  }

  List<Widget> _buildStepsList(String steps) {
    List<String> stepList = steps.split('\r\n');

    return stepList
        .asMap()
        .entries
        .map((entry) {
      int index = entry.key;
      String step = entry.value;
      return Visibility(
        visible: _stepsExpanded || index < 3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                step,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget buildCircularIndicator({
    required double percent,
    required String value,
    required String label,
  }) {
    return CircularPercentIndicator(
      radius: 60.r,
      lineWidth: 3.w,
      animation: true,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.orange,
      backgroundColor: AppColors.lightGrey,
    );
  }
}

