import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors.dart';

@RoutePage()
class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Grocery List', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                side: const BorderSide(color: Colors.white),
                onChanged: null,
              ),
              Text(
                'Select all',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              const Spacer(),
              TextButton(
                onPressed: null,
                child: Text("Done", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Static count for demo purposes
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.r),
                        ),
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        activeColor: Colors.transparent,
                        checkColor: Colors.white,
                        value: false,
                        onChanged: null,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                              activeColor: Colors.transparent,
                              checkColor: Colors.white,
                              value: false,
                              onChanged: null,
                            ),
                            title: Text(
                              'Ingredient $index',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: const BorderSide(color: AppColors.white),
                  ),
                  backgroundColor: AppColors.white,
                ),
                onPressed: null,
                child: const Text(
                  'Add new ingredient',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
