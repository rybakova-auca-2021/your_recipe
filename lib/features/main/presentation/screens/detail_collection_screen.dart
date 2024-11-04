import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:your_recipe/features/main/domain/usecase/view_recipes_in_collection_use_case.dart';
import 'package:your_recipe/features/main/presentation/bloc/collection_recipes_bloc/collection_recipe_bloc.dart';

import '../../../../../../core/colors.dart';
import '../../../../../../core/widgets/recipe_card.dart';

@RoutePage()
class DetailCollectionScreen extends StatefulWidget {
  const DetailCollectionScreen({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  State<DetailCollectionScreen> createState() => _DetailCollectionScreenState();
}

class _DetailCollectionScreenState extends State<DetailCollectionScreen> {
  late final CollectionRecipeBloc _blocCollectionsRecipes;

  @override
  void initState() {
    super.initState();
    _blocCollectionsRecipes = CollectionRecipeBloc(
      GetIt.I<ViewRecipesInCollectionUseCase>(),
    );
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    _blocCollectionsRecipes.add(FetchCollectionRecipesEvent(widget.id));
  }

  @override
  void dispose() {
    _blocCollectionsRecipes.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder<CollectionRecipeBloc, CollectionRecipeState>(
          bloc: _blocCollectionsRecipes,
          builder: (context, state) {
            if (state is CollectionRecipesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CollectionRecipesLoaded) {
              final recipes = state.recipes;
              return ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeCard(
                    imageUrl: recipe.imageUrl,
                    title: recipe.name,
                    prepTime: "${recipe.time}",
                    servings: "${recipe.numberOfPeople}",
                  );
                },
              );
            } else if (state is CollectionRecipesError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('No recipes available.'));
          },
        ),
      ),
    );
  }
}
