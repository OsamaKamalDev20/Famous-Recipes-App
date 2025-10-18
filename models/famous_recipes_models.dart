// To parse this JSON data, do
//
//     final famousRecipes = famousRecipesFromJson(jsonString);

import 'dart:convert';

List<FamousRecipes> famousRecipesFromJson(String str) =>
    List<FamousRecipes>.from(
        json.decode(str).map((x) => FamousRecipes.fromJson(x)));

String famousRecipesToJson(List<FamousRecipes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FamousRecipes {
  int id;
  String title;
  String course;
  Cuisine cuisine;
  String mainIngredient;
  String description;
  String source;
  String url;
  String urlHost;
  int prepTime;
  int cookTime;
  int totalTime;
  int servings;
  dynamic famousRecipeYield;
  String ingredients;
  String directions;
  String tags;
  String rating;
  String publicUrl;
  String photoUrl;
  Private private;
  String nutritionalScoreGeneric;
  dynamic calories;
  String fat;
  String cholesterol;
  dynamic sodium;
  String sugar;
  String carbohydrate;
  String fiber;
  String protein;
  String cost;

  FamousRecipes({
    required this.id,
    required this.title,
    required this.course,
    required this.cuisine,
    required this.mainIngredient,
    required this.description,
    required this.source,
    required this.url,
    required this.urlHost,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.servings,
    required this.famousRecipeYield,
    required this.ingredients,
    required this.directions,
    required this.tags,
    required this.rating,
    required this.publicUrl,
    required this.photoUrl,
    required this.private,
    required this.nutritionalScoreGeneric,
    required this.calories,
    required this.fat,
    required this.cholesterol,
    required this.sodium,
    required this.sugar,
    required this.carbohydrate,
    required this.fiber,
    required this.protein,
    required this.cost,
  });

  factory FamousRecipes.fromJson(Map<String, dynamic> json) => FamousRecipes(
        id: json["id"],
        title: json["title"],
        course: json["course"],
        cuisine: cuisineValues.map[json["cuisine"]]!,
        mainIngredient: json["mainIngredient"],
        description: json["description"],
        source: json["source"],
        url: json["url"],
        urlHost: json["urlHost"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        totalTime: json["totalTime"],
        servings: json["servings"],
        famousRecipeYield: json["yield"],
        ingredients: json["ingredients"],
        directions: json["directions"],
        tags: json["tags"],
        rating: json["rating"],
        publicUrl: json["publicUrl"],
        photoUrl: json["photoUrl"],
        private: privateValues.map[json["private"]]!,
        nutritionalScoreGeneric: json["nutritionalScoreGeneric"],
        calories: json["calories"],
        fat: json["fat"],
        cholesterol: json["cholesterol"],
        sodium: json["sodium"],
        sugar: json["sugar"],
        carbohydrate: json["carbohydrate"],
        fiber: json["fiber"],
        protein: json["protein"],
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "course": course,
        "cuisine": cuisineValues.reverse[cuisine],
        "mainIngredient": mainIngredient,
        "description": description,
        "source": source,
        "url": url,
        "urlHost": urlHost,
        "prepTime": prepTime,
        "cookTime": cookTime,
        "totalTime": totalTime,
        "servings": servings,
        "yield": famousRecipeYield,
        "ingredients": ingredients,
        "directions": directions,
        "tags": tags,
        "rating": rating,
        "publicUrl": publicUrl,
        "photoUrl": photoUrl,
        "private": privateValues.reverse[private],
        "nutritionalScoreGeneric": nutritionalScoreGeneric,
        "calories": calories,
        "fat": fat,
        "cholesterol": cholesterol,
        "sodium": sodium,
        "sugar": sugar,
        "carbohydrate": carbohydrate,
        "fiber": fiber,
        "protein": protein,
        "cost": cost,
      };
}

enum Cuisine { AMERICAN, ASIAN, EMPTY, ITALIAN, MEXICAN }

final cuisineValues = EnumValues({
  "American": Cuisine.AMERICAN,
  "Asian": Cuisine.ASIAN,
  "": Cuisine.EMPTY,
  "Italian": Cuisine.ITALIAN,
  "Mexican": Cuisine.MEXICAN
});

enum Private { NO }

final privateValues = EnumValues({"no": Private.NO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
