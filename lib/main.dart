import 'package:flutter/material.dart';
import 'package:your_recipe/recipe_app.dart';

import 'core/di.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const RecipeApp());
}
