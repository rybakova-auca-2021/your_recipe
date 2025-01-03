import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/features/grocery/presentation/bloc/grocery_bloc/grocery_bloc.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/grocery_item_response_entity.dart';

class GroceryItemTile extends StatefulWidget {
  final GroceryItemResponseEntity groceryItem;
  final bool isSelectionMode;
  final bool isSelected;
  final bool isPurchased;
  final ValueChanged<bool?> onSelectChanged;
  final ValueChanged<bool?> onPurchasedChanged;

  const GroceryItemTile({
    Key? key,
    required this.groceryItem,
    required this.isSelectionMode,
    required this.onSelectChanged,
    required this.isSelected,
    required this.onPurchasedChanged,
    required this.isPurchased
  }) : super(key: key);

  @override
  _GroceryItemTileState createState() => _GroceryItemTileState();
}

class _GroceryItemTileState extends State<GroceryItemTile> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.groceryItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroceryBloc, GroceryState>(
      listener: (context, state) {
        if (state is EditGrocerySuccess && state.groceryItem.id == widget.groceryItem.id) {
          setState(() {
            quantity = int.parse(state.groceryItem.quantity);
          });
        }
      },
      child: _buildGroceryTile(context),
    );
  }

  Widget _buildGroceryTile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.r),
      child: Dismissible(
        key: Key(widget.groceryItem.id.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await _showDeleteIngredientDialog(context, widget.groceryItem.id);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 8.r, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.isSelectionMode)
                Checkbox(
                  activeColor: Colors.orange,
                  value: widget.isSelected,
                  onChanged: widget.onSelectChanged,
                ),
              Expanded(
                child: Text(
                  widget.groceryItem.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.lightGrey,
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              _updateQuantity(context, quantity - 1);
                            }
                          },
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${quantity}kg',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        backgroundColor: AppColors.lightGrey,
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            _updateQuantity(context, quantity + 1);
                          },
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Checkbox(
                activeColor: Colors.orange,
                value: widget.isPurchased,
                onChanged: (bool? newValue) {
                  widget.onPurchasedChanged(newValue ?? false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteIngredientDialog(BuildContext context, int id) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Delete ingredient?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel', style: TextStyle(color: AppColors.orange)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text('OK', style: TextStyle(color: AppColors.orange)),
              onPressed: () {
                context.read<GroceryBloc>().add(GroceryDeleted(id));
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _updateQuantity(BuildContext context, int newQuantity) {
    context.read<GroceryBloc>().add(
      GroceryEdited(
        id: widget.groceryItem.id,
        name: widget.groceryItem.name,
        quantity: newQuantity.toString(),
      ),
    );
  }
}
