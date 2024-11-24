import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_recipe/router/app_router.dart';

import '../bloc/add_cuisine_bloc/add_cuisine_bloc.dart';
import '../bloc/fetch_cuisine_bloc/fetch_cuisine_bloc.dart';

@RoutePage()
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final Set<int> selectedCuisineIds = {};
  final Random random = Random();

  List<double>? circleSizes;

  @override
  void initState() {
    super.initState();
    context.read<FetchCuisineBloc>().add(FetchCuisinesEvent());
  }

  double getRandomSize() {
    return 70.0 + random.nextInt(100);
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
      body: BlocBuilder<FetchCuisineBloc, FetchCuisineState>(
        builder: (context, state) {
          if (state is FetchCuisineLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchCuisineSuccess) {
            final cuisines = state.cuisines;

            // Initialize circleSizes only if not already initialized
            circleSizes ??= List.generate(cuisines.length, (index) => getRandomSize());

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
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Choose your favorite cuisines",
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
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: List.generate(cuisines.length, (index) {
                          final cuisine = cuisines[index];
                          final isSelected = selectedCuisineIds.contains(cuisine.id);
                          final double size = circleSizes![index]; // Safe access since it's initialized.

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedCuisineIds.remove(cuisine.id);
                                } else {
                                  selectedCuisineIds.add(cuisine.id);
                                }
                              });
                            },
                            child: Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.amber.shade700
                                    : Colors.grey.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  cuisine.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                // Continue button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<AddPreferredCuisineBloc, AddPreferredCuisineState>(
                    listener: (context, state) {
                      if (state is AddPreferredCuisineSuccess) {
                        AutoRouter.of(context).push(const FoodPreferenceRoute());
                      } else if (state is AddPreferredCuisineFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is AddPreferredCuisineLoading
                            ? null
                            : () {
                          print("SELECTED CUISINES IDS ${selectedCuisineIds.toList()}");
                          context.read<AddPreferredCuisineBloc>().add(
                            SubmitPreferredCuisinesEvent(
                              cuisineIds: selectedCuisineIds.toList(),
                            ),
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
                        child: state is AddPreferredCuisineLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Continue"),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FetchCuisineFailure) {
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
