import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/ingredients/domain/entity/ingredient.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/ingredient_bloc/ingredient_bloc.dart';
import '../../domain/usecase/add_ingredient_usecase.dart';
import '../../domain/usecase/delete_all_ingredients_usecase.dart';
import '../../domain/usecase/delete_ingredient_usecase.dart';
import '../../domain/usecase/edit_ingredient_usecase.dart';
import '../../domain/usecase/view_ingredients_usecase.dart';

import '../widget/add_ingredient_dialog.dart';
import '../widget/ingredient_list.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _categories = ['Expired', 'Fruits', 'Vegetables', 'Meat', 'Others'];
  late String selectedCategory;

  final _blocIngredient = IngredientBloc(
    addUseCase: GetIt.I<AddIngredientUseCase>(),
    deleteAllUseCase: GetIt.I<DeleteAllIngredientsUseCase>(),
    deleteUseCase: GetIt.I<DeleteIngredientUseCase>(),
    editUseCase: GetIt.I<EditIngredientUseCase>(),
    viewUseCase: GetIt.I<ViewIngredientsUseCase>(),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    selectedCategory = _categories[0];
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        selectedCategory = _categories[_tabController.index];
      });
    }
  }

  void _showDeleteIngredientDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete all ingredients?', style: TextStyle(fontWeight: FontWeight.bold)),
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
                _blocIngredient.add(
                    DeleteAllIngredients(category: selectedCategory)
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _blocIngredient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _blocIngredient,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text('My Ingredients', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          actions: [
            IconButton(
              onPressed: _showDeleteIngredientDialog,
              icon: const Icon(Icons.delete, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
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
                          child: AddIngredientBottomSheet(
                            mode: "add",
                            category: selectedCategory,
                            onSave: (Ingredient ingredient) {
                              _blocIngredient.add(
                                  AddIngredient(
                                  name: ingredient.name,
                                  quantity: ingredient.quantity ?? '1',
                                  manufactureDate: ingredient.manufactureDate ?? '',
                                  expirationDate: ingredient.expirationDate ?? '',
                                  category: ingredient.category
                                )
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.add, color: Colors.black87),
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 16.sp),
            unselectedLabelColor: Colors.orange,
            controller: _tabController,
            isScrollable: true,
            tabs: _categories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _categories.map((category) => IngredientsListView(category: category)).toList(),
        ),
      ),
    );
  }
}
