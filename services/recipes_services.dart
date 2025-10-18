import 'package:flutter_ui_designs/Famous%20Recipes%20App/models/famous_recipes_models.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/models/popular_recipes_models.dart';
import 'package:http/http.dart' as http;

class FamousRecipesServices {
  static const String famousRecipesUrl =
      "https://api.sampleapis.com/recipes/recipes";

  // Fetch all recipes
  static Future<List<FamousRecipes>> fetchFamousRecipes() async {
    final response = await http.get(Uri.parse(famousRecipesUrl));

    if (response.statusCode == 200) {
      return famousRecipesFromJson(response.body);
    } else {
      throw Exception("Failed to load famous recipes");
    }
  }
}

class PopularRecipesServices {
  static Future<PopularRecipes> fetchPopularRecipes() async {
    final popularRecipeUrl = Uri.parse('https://dummyjson.com/recipes');
    try {
      final response = await http.get(popularRecipeUrl);
      if (response.statusCode == 200) {
        return popularRecipesFromJson(response.body);
      } else {
        throw Exception(
            'Failed to load popular recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular recipes: $e');
    }
  }
}
