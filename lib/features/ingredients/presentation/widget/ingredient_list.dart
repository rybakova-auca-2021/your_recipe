import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/delete_grocery/delete_ingredient_bloc.dart';

import '../../domain/entity/ingredient.dart';
import '../bloc/view_all_groceries/view_all_ingredients_bloc.dart';
import 'add_ingredient_dialog.dart';
import 'ingredients_detail_dialog.dart';

class IngredientsListView extends StatefulWidget {
  const IngredientsListView({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<IngredientsListView> createState() => _IngredientsListViewState();
}

class _IngredientsListViewState extends State<IngredientsListView> {

  @override
  void initState() {
    super.initState();
    _loadIngredients(widget.category);
  }

  Future<void> _loadIngredients(String category) async {
    context.read<ViewAllIngredientsBloc>().add(AllIngredientsViewed(category: category));
  }

  Widget slideLeftBackground() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.red,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Icon(Icons.delete_outline, color: Colors.white, size: 40),
              SizedBox(width: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.orange,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.edit, color: Colors.white, size: 40),
                SizedBox(width: 20.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteIngredientDialog(BuildContext context, int id) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete ingredient?', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel', style: TextStyle(color: AppColors.orange)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('OK', style: TextStyle(color: AppColors.orange)),
              onPressed: () {
                context.read<DeleteIngredientBloc>().add(
                    IngredientDeleted(id: id, category: widget.category)
                );
                context.read<ViewAllIngredientsBloc>().add(AllIngredientsViewed(category: widget.category));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showIngredientDetails(BuildContext context, Ingredient ingredient) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (BuildContext context) {
        return IngredientDetailsBottomSheet(
          title: ingredient.name,
          manufactureDate: ingredient.manufactureDate ?? '',
          expirationDate: ingredient.expirationDate ?? '',
        );
      },
    );
  }

  void _showAddIngredientBottomSheet(BuildContext context, Ingredient ingredient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddIngredientBottomSheet(mode: "edit", ingredient: ingredient, category: widget.category),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewAllIngredientsBloc, ViewAllIngredientsState>(
      listener: (context, state) {
        if (state is ViewAllIngredientsSuccess) {

        }
        if (state is ViewAllIngredientsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocBuilder<ViewAllIngredientsBloc, ViewAllIngredientsState>(
        builder: (context, state) {
          if (state is ViewAllIngredientsLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.orange));
          } else if (state is ViewAllIngredientsError) {
            return Center(child: Text(state.message));
          } else if (state is ViewAllIngredientsSuccess) {
            final ingredients = state.ingredients;

            if (ingredients.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "No ingredients available for the chosen category.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: ListView.builder(
                key: ValueKey(ingredients.length),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];
                  return Dismissible(
                    key: Key('ingredient-${ingredient.id}'),
                    direction: DismissDirection.horizontal,
                    background: slideRightBackground(),
                    secondaryBackground: slideLeftBackground(),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        _showAddIngredientBottomSheet(context, ingredient);
                        return false;
                      } else if (direction == DismissDirection.endToStart) {
                        _showDeleteIngredientDialog(context, ingredient.id!);
                        return false;
                      }
                      return false;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.r),
                      child: SizedBox(
                        height: 85.h,
                        child: Card(
                          elevation: 0,
                          color: AppColors.lightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: ListTile(
                            title: Text(
                              ingredient.name,
                              style: TextStyle(color: Colors.black, fontSize: 18.sp),
                            ),
                            subtitle: Text(
                              _getExpirationStatus(ingredient.manufactureDate, ingredient.expirationDate),
                              style: const TextStyle(color: Colors.black87),
                            ),
                            onTap: () {
                              _showIngredientDetails(context, ingredient);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No ingredients available."));
          }
        },
      ),
    );
  }
}

String _getExpirationStatus(String? manufactureDateStr, String? expirationDateStr) {
  if (manufactureDateStr == null || expirationDateStr == null) return 'Date unavailable';

  // Parse dates with custom format DD.MM.YYYY
  DateTime? manufactureDate = _parseDate(manufactureDateStr);
  DateTime? expirationDate = _parseDate(expirationDateStr);

  if (manufactureDate == null || expirationDate == null) return 'Invalid date';

  final currentDate = DateTime.now();

  if (expirationDate.isBefore(currentDate)) {
    return 'Expired';
  } else {
    final daysLeft = expirationDate.difference(currentDate).inDays;
    return 'Expires in $daysLeft days';
  }
}

DateTime? _parseDate(String dateStr) {
  try {
    final parts = dateStr.split('.');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
  } catch (e) {
    print("error $e");
  }
  return null;
}

