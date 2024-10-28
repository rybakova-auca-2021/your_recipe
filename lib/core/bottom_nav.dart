import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/features/grocery/presentation/screens/grocery_screen.dart';
import 'package:your_recipe/features/ingredients/ingredients_screen.dart';
import 'package:your_recipe/features/main/main_screen.dart';
import 'package:your_recipe/features/profile/presentation/pages/profile_screen.dart';
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

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(40),
            ),
            height: 66,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: buildNavItem(0, CupertinoIcons.home),
                ),
                Expanded(
                  child: buildNavItem(1, CupertinoIcons.list_bullet),
                ),
                Expanded(
                  child: buildNavItem(2, CupertinoIcons.heart),
                ),
                Expanded(
                  child: buildNavItem(3, CupertinoIcons.person),
                ),
              ],
            ),
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
    const IngredientsScreen(),
    const GroceryScreen(),
    const ProfileScreen(),
  ];
}
