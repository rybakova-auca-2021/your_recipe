import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_recipe/core/colors.dart';
import 'package:your_recipe/router/app_router.dart';

@RoutePage()
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Map<String, bool> _filters = {
    '10-25 min': false,
    '30-45 min': false,
    'under 60 min': false,
    '1-2': false,
    '2-4': false,
    '6-10': false,
    'super easy': false,
    'not too tricky': false,
    'showing off': false,
    'vegetarian recipes': false,
    'gluten-free recipes': false,
    'budget-friendly recipes': false,
  };

  bool _showResultsButton = false;

  void _toggleFilter(String filter, List<String> sectionFilters) {
    setState(() {
      for (var f in sectionFilters) {
        if (f != filter) {
          _filters[f] = false;
        }
      }
      _filters[filter] = !_filters[filter]!;
      _showResultsButton = _filters.containsValue(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Filters', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _filters.updateAll((key, value) => false);
                _showResultsButton = false;
              });
            },
            child: const Text(
              'Clear all',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Preparation time'),
               SizedBox(height: 12.h),
              _buildFilterRow(['10-25 min', '30-45 min', 'under 60 min']),
               SizedBox(height: 16.h),
              _buildSectionTitle('Number of servings'),
               SizedBox(height: 12.h),
              _buildFilterRow(['1-2', '2-4', '6-10']),
               SizedBox(height: 16.h),
              _buildSectionTitle('Difficulty'),
               SizedBox(height: 12.h),
              _buildFilterRow(['super easy', 'not too tricky', 'showing off']),
               SizedBox(height: 16.h),
              _buildSectionTitle('Preferences'),
               SizedBox(height: 12.h),
              _buildFilterRow([
                'vegetarian recipes',
                'gluten-free recipes',
                'budget-friendly recipes'
              ]),
               SizedBox(height: 16.h),
              if (_showResultsButton)
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(RecipeFilterRoute(filters: _filters));
                  },
                  child: Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child:  Center(
                      child: Text(
                        'Show results',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFilterRow(List<String> filters) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: filters.map((filter) {
        return _buildFilterButton(filter, filters);
      }).toList(),
    );
  }

  Widget _buildFilterButton(String filter, List<String> sectionFilters) {
    return GestureDetector(
      onTap: () => _toggleFilter(filter, sectionFilters),
      child: Container(
        width: 160.w,
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: _filters[filter]! ? AppColors.orange : Colors.orange
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: _filters[filter]! ? AppColors.orange : Colors.transparent,
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              color: _filters[filter]! ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
