import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';

final List<Map<String, String>> _categories = [
  {'name': 'Fruits', 'imagePath': "https://i.ibb.co/phLJVgY/fruits.png"},
  {'name': 'Vegetables', 'imagePath': 'https://i.ibb.co/K6pTnd5/vegetables.png'},
  {'name': 'Meat', 'imagePath': 'https://i.ibb.co/TY8mv7G/meat.png'},
  {'name': 'Dairy', 'imagePath': 'https://i.ibb.co/KwvBv2T/dairy.png'},
];

class CategoryDialog extends StatefulWidget {
  final Function(String?) onCategorySelected;

  const CategoryDialog({super.key, required this.onCategorySelected});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Select Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category['name'];
                    });
                    widget.onCategorySelected(selectedCategory);
                    Navigator.pop(context);
                  },
                  child: Card(
                    color: AppColors.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          category['imagePath']!,
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
