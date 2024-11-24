import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/router/app_router.dart';

import '../bloc/add_food_bloc/add_food_bloc.dart';
import '../bloc/fetch_food_bloc/fetch_food_bloc.dart';

@RoutePage()
class FoodPreferenceScreen extends StatefulWidget {
  const FoodPreferenceScreen({super.key});

  @override
  State<FoodPreferenceScreen> createState() => _FoodPreferenceScreenState();
}

class _FoodPreferenceScreenState extends State<FoodPreferenceScreen> {
  final Set<int> selectedFoodIds = {};

  @override
  void initState() {
    super.initState();
    context.read<FetchFoodBloc>().add(FetchFoodsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: BlocBuilder<FetchFoodBloc, FetchFoodState>(
        builder: (context, state) {
          if (state is FetchFoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchFoodSuccess) {
            final foodItems = state.cuisines;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Choose your favorite food",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemCount: foodItems.length,
                      itemBuilder: (context, index) {
                        final food = foodItems[index];
                        final isSelected = selectedFoodIds.contains(food.id);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedFoodIds.remove(food.id);
                              } else {
                                selectedFoodIds.add(food.id);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.amber.shade700
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                food.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Continue button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<AddPreferredFoodBloc, AddPreferredFoodState>(
                    listener: (context, state) {
                      if (state is AddPreferredFoodSuccess) {
                        AutoRouter.of(context).push(BottomNavRoute());
                      } else if (state is AddPreferredFoodFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is AddPreferredFoodLoading
                            ? null
                            : () {
                          context.read<AddPreferredFoodBloc>().add(
                            SubmitPreferredFoodEvent(foodIds: selectedFoodIds.toList()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: state is AddPreferredFoodLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Continue"),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FetchFoodFailure) {
            return Center(
              child: Text("Error: ${state.error}"),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
