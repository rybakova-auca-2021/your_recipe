import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:your_recipe/features/meal_creation/presentation/widgets/form_by_picture_creation.dart';
import 'package:your_recipe/features/meal_creation/presentation/widgets/form_meal_creation.dart';
import 'package:your_recipe/features/meal_creation/presentation/widgets/loading_meal_widget.dart';

import '../domain/cubit/meal/meal_cubit.dart';

@RoutePage()
class MealCreationPage extends StatelessWidget {
  const MealCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: BlocBuilder<MealCubit, MealState>(
            builder: (context, state) => Text(
              switch (state) {
                MealSettingsParameters() => 'Generate recipe with AI',
                MealLoading() => '',
                MealLoaded() => 'Your meal is ready',
                ErrorState() => 'Customize your receipt',
              },
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          centerTitle: false,
          bottom: const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: 'With Ingredients'),
              Tab(text: 'By Food Picture'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // first tab
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<MealCubit, MealState>(
                  builder: (context, state) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: switch (state) {
                      MealSettingsParameters() => FormMealCreation(state: state),
                      MealLoading() => const Center(child: LoadingMealWidget()),
                      MealLoaded() => Markdown(data: state.meals.first),
                      ErrorState() => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cannot generate recipe',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.error.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context.read<MealCubit>().load(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: Text(
                              "Try again",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    },
                  ),
                ),
              ),
              // second tab
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<MealCubit, MealState>(
                  builder: (context, state) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: switch (state) {
                      MealSettingsParameters() => FormByPictureCreation(state: state),
                      MealLoading() => const Center(child: LoadingMealWidget()),
                      MealLoaded() => Markdown(data: state.meals.first),
                      ErrorState() => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cannot generate recipe',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.error.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context.read<MealCubit>().load(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: Text(
                              "Try again",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<MealCubit, MealState>(
          builder: (context, state) => switch (state) {
            MealLoaded() => FloatingActionButton(
              onPressed: () => context.read<MealCubit>().load(),
              backgroundColor: Colors.orange,
              child: const Icon(Icons.restart_alt_rounded, color: Colors.white),
            ),
            MealLoading() || MealSettingsParameters() || ErrorState() => const SizedBox(),
          },
        ),
      ),
    );
  }
}
