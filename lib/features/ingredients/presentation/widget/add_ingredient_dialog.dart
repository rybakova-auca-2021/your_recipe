import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/ingredients/presentation/bloc/ingredient_bloc/ingredient_bloc.dart';
import 'package:your_recipe/features/ingredients/presentation/widget/category_dialog.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/ingredient.dart';
import 'date_picker_dialog.dart';

class AddIngredientBottomSheet extends StatefulWidget {
  final String mode;
  final Ingredient? ingredient;
  final String category;
  final Function(Ingredient) onSave;

  const AddIngredientBottomSheet({
    super.key,
    required this.mode,
    this.ingredient,
    required this.category,
    required this.onSave
  });

  @override
  _AddIngredientBottomSheetState createState() => _AddIngredientBottomSheetState();
}

class _AddIngredientBottomSheetState extends State<AddIngredientBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _manufactureDateController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      _nameController.text = widget.ingredient!.name;
      _manufactureDateController.text = widget.ingredient!.manufactureDate ?? '';
      _expirationDateController.text = widget.ingredient!.expirationDate ?? '';
      _quantityController.text = widget.ingredient!.quantity ?? '';
      _selectedCategory = widget.ingredient!.category;
    }
  }

  bool _areFieldsFilled() {
    return _nameController.text.isNotEmpty &&
        _manufactureDateController.text.isNotEmpty &&
        _expirationDateController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _selectedCategory != null;
  }

  void _clearFields() {
    _nameController.clear();
    _manufactureDateController.clear();
    _expirationDateController.clear();
    _quantityController.clear();
    setState(() {
      _selectedCategory = null;
    });
  }


  void _selectDate(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DatePickerBottomSheet(
          initialDate: DateTime.now(),
          onDateSelected: (DateTime selectedDate) {
            final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
            controller.text = formattedDate;
            setState(() {});
          },
        );
      },
    );
  }


  void _selectCategory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return CategoryDialog(
          onCategorySelected: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.mode == "edit";
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isEditMode ? 'Edit ingredient' : 'Add a new ingredient',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Text(
              'You can write needed information here',
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name of ingredient',
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _manufactureDateController,
              readOnly: true,
              onTap: () => _selectDate(context, _manufactureDateController),
              decoration: InputDecoration(
                hintText: 'Date of manufacture',
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey, size: 20.r),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _expirationDateController,
              readOnly: true,
              onTap: () => _selectDate(context, _expirationDateController),
              decoration: InputDecoration(
                hintText: 'Expiration date',
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey, size: 20.r),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                hintText: 'Quantity',
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: _selectCategory,
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory ?? 'Select category',
                      style: TextStyle(color: _selectedCategory != null ? Colors.black : Colors.grey),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton.icon(
              onPressed: _areFieldsFilled()
                  ? () {
                final ingredient = Ingredient(
                  id: widget.ingredient?.id,
                  name: _nameController.text,
                  quantity: _quantityController.text,
                  manufactureDate: _manufactureDateController.text,
                  expirationDate: _expirationDateController.text,
                  category: _selectedCategory!,
                );

                widget.onSave(ingredient);
                _clearFields();
                Navigator.pop(context);
              }
                  : null,
              label: Text(
                isEditMode ? 'Edit' : 'Add',
                style: const TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: _areFieldsFilled() ? AppColors.orange : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
