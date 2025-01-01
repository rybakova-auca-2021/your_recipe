import 'package:google_generative_ai/google_generative_ai.dart';

import '../../domain/cubit/meal/meal_cubit.dart';
import '../../domain/repository/meal_repository.dart';

class GeminiMealRepository extends AbstractMealRepository {
  final apiKey = "AIzaSyDbngu2SjJaHwIRoYRLPwmuEHfBdEIJp3I";

  @override
  Future<List<String>> getMeals(MealSettingsParameters parameters) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    final prompt = _generatePrompt(parameters);
    final image = await parameters.picture?.readAsBytes();
    final mimetype = parameters.picture?.mimeType ?? 'image/jpeg';

    final List<Part> contentList = [TextPart(prompt)];
    if (image != null) {
      contentList.add(DataPart(mimetype, image));
    }
    final response = await model.generateContent([
      Content.multi(contentList),
    ]);

    return [response.text!];
  }

  String _generatePrompt(MealSettingsParameters parameters) {
    String prompt;

    if (parameters.type == 'image' && parameters.picture != null) {
      prompt = '''
I have found this food picture and can you please write me name, ingredients and steps to cook it  
 Please format your response in Markdown for clarity.
      ''';
    } else if (parameters.type == 'ingredients' && parameters.ingredients != null && parameters.ingredients!.isNotEmpty) {
      prompt = '''
You are a very experienced diet planner. I want to have 1 option for a meal using only the ingredients provided. 
I need the recipe step by step to easily understand it and format it using only Markdown. 
I want the quantity of the ingredients for ${parameters.people.toString()} people and I only want to spend a maximum of ${parameters.maxTimeCooking.toString()} minutes to make the meal.
The ingredients are: ${parameters.ingredients}. Please create a recipe using these ingredients.
      ''';
    } else {
      throw ArgumentError('Invalid parameters: Missing necessary data for prompt generation.');
    }

    if (parameters.intoleranceOrLimits != null) {
      prompt += '''
I have the following intolerances or limits: ${parameters.intoleranceOrLimits}.
      ''';
    }

    return prompt;
  }
}
