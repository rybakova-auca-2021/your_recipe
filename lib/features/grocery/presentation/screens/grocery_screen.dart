import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/features/grocery/domain/entities/grocery_item_response_entity.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_groceries_use_case.dart';
import 'package:your_recipe/features/grocery/domain/usecase/add_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/delete_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/edit_grocery_usecase.dart';
import 'package:your_recipe/features/grocery/domain/usecase/view_groceries_usecase.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';
import 'package:your_recipe/features/grocery/presentation/widgets/grocery_item_tile.dart';
import '../../../../core/colors.dart';
import '../../../../core/csv_export.dart';
import '../../domain/usecase/delete_all_groceries_usecase.dart';

@RoutePage()
class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryScreen> {
  final _blocAllGroceries = GroceryBloc(
    viewUsecase: GetIt.I<ViewGroceriesUsecase>(),
    addUsecase: GetIt.I<AddGroceryUsecase>(),
    addMultipleUsecase: GetIt.I<AddGroceriesUseCase>(),
    deleteAllUsecase: GetIt.I<DeleteAllGroceriesUsecase>(),
    deleteUsecase: GetIt.I<DeleteGroceryUsecase>(),
    editUsecase: GetIt.I<EditGroceryUsecase>(),
  );

  bool _isSelectionMode = false;
  List<bool> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _loadGroceries();
  }

  Future<void> _loadGroceries() async {
    _blocAllGroceries.add(AllGroceriesViewed());
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedItems = List.filled(_selectedItems.length, false);
      } else {
        _selectedItems = List.filled(_selectedItems.length, true);
      }
    });
  }

  void _showAddIngredientDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Add New Ingredient',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CupertinoTextField(
              controller: controller,
              placeholder: 'Enter',
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                _blocAllGroceries.add(GroceryAdded(name: controller.text, quantity: "1"));
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteIngredientDialog() {
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
                _blocAllGroceries.add(AllGroceriesDeleted());
                Navigator.of(context).pop();
                setState(() {
                  _isSelectionMode = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<GroceryItemResponseEntity> groceries = [];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Grocery List',
          style: TextStyle(color: Colors.orange),
        ),
        actions: [
          TextButton(
            onPressed: _toggleSelectionMode,
            child: Text(
              _isSelectionMode ? "Cancel" : "Select all",
              style: TextStyle(color: Colors.orange, fontSize: 14.sp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadGroceries,
                child: BlocBuilder<GroceryBloc, GroceryState>(
                  bloc: _blocAllGroceries,
                  builder: (context, state) {
                    if (state is GroceryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      );
                    } else if (state is ViewAllGroceriesSuccess) {
                      groceries = state.groceries;
                      if (_selectedItems.length != groceries.length) {
                        _selectedItems = List.filled(groceries.length, false);
                      }
                      return ListView.builder(
                        itemCount: groceries.isEmpty ? 1 : groceries.length,
                        itemBuilder: (context, index) {
                          if (groceries.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.3.sh),
                                child: const Text(
                                  "No data yet. Pull to refresh.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          }

                          final groceryItem = groceries[index];
                          return GroceryItemTile(
                            groceryItem: groceryItem,
                            isSelectionMode: _isSelectionMode,
                            isSelected: _selectedItems[index],
                            onSelectChanged: (value) {
                              setState(() {
                                _selectedItems[index] = value!;
                              });
                            },
                          );
                        },
                      );
                    } else if (state is GroceryError) {
                      return Center(
                        child: Text(
                          "Failed to load groceries",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return Container(); // Default empty state
                  },
                ),
              ),

            ),
            SizedBox(height: 16.h),
            _isSelectionMode
                ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      backgroundColor: AppColors.orange,
                    ),
                    onPressed: () async {
                      if (groceries.isNotEmpty) {
                        await exportAndShareGroceries(groceries);
                      }
                    },
                    child: const Text(
                      'Export',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: const BorderSide(color: AppColors.red),
                      ),
                      backgroundColor: AppColors.red,
                    ),
                    onPressed: _showDeleteIngredientDialog,
                    child: const Text(
                      'Delete all ingredients',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            )
                : SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: const BorderSide(color: AppColors.orange),
                  ),
                  backgroundColor: AppColors.orange,
                ),
                onPressed: () {
                  _showAddIngredientDialog(context);
                },
                child: const Text(
                  'Add new ingredient',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

