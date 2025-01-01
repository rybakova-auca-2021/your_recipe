import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/core/widgets/recipe_card.dart';
import 'package:your_recipe/features/grocery/presentation/screens/grocery_screen.dart';
import 'package:your_recipe/features/ingredients/presentation/screen/ingredients_screen.dart';
import 'package:your_recipe/features/main/presentation/screens/main_screen.dart';
import 'package:your_recipe/features/meal_creation/presentation/meal_creation_page.dart';
import 'package:your_recipe/features/profile/presentation/pages/profile_screen.dart';
import 'package:your_recipe/router/app_router.dart';

import '../features/profile/presentation/pages/favorites_screen.dart';

@RoutePage()
class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key, this.indexScr = 0});

  final int indexScr;

  @override
  State<BottomNavPage> createState() => BottomNavState();
}

class BottomNavState extends State<BottomNavPage> {
  late int _currentIndex;
  bool _isMealCreation = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          if (_isMealCreation) const MealCreationPage(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          color: AppColors.white,
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: buildNavItem(0, CupertinoIcons.home),
                  ),
                  Expanded(
                    child: buildNavItem(1, CupertinoIcons.list_bullet),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Expanded(
                    child: buildNavItem(2, CupertinoIcons.heart),
                  ),
                  Expanded(
                    child: buildNavItem(3, CupertinoIcons.person),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _isMealCreation = true;
                      });
                    },
                    backgroundColor: AppColors.orange,
                    shape: const CircleBorder(),
                    child: const Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, IconData iconData) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _isMealCreation = false;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: isSelected ? AppColors.orange : Colors.grey,
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }

  final _pages = <Widget>[
    const MainScreen(),
    const GroceryScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];
}

