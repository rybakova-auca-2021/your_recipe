import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets/recipe_card.dart';

@RoutePage()
class AddMealPlanScreen extends StatelessWidget {
  const AddMealPlanScreen({super.key});

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
            labelColor: AppColors.orange,
            labelStyle: TextStyle(
              fontSize: 16.sp
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
        body: TabBarView(
          children: [
            _buildTabContent('Breakfast'),
            _buildTabContent('Lunch'),
            _buildTabContent('Dinner'),
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
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return RecipeCard(
                  imageUrl: 'https://i.ibb.co/LgqrCJ4/food.jpg',
                  title: '$mealType Recipe ${index + 1}',
                  prepTime: 15 + index * 5,
                  servings: 2 + index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
