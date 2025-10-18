// ✅ Onboarding Screen Headings Recipe App
import 'package:flutter/material.dart';

class OnBoardingScreenRecipe {
  String image, title, description;

  OnBoardingScreenRecipe({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnBoardingScreenRecipe> recipes = [
  OnBoardingScreenRecipe(
    title: "Discover New Recipes",
    image: "assets/recipes/recipe-onboarding-4.jpg",
    description:
        "Explore thousands of recipes from around the world. From appetizers to desserts, find dishes that suit your taste.",
  ),
  OnBoardingScreenRecipe(
    title: "Save Your Favorites",
    image: "assets/recipes/recipe-onboarding-5.jpg",
    description:
        "Bookmark your favorite recipes to access anytime. Organize them in custom collections for easy reference",
  ),
  OnBoardingScreenRecipe(
    title: "Step-by-Step Instructions",
    image: "assets/recipes/recipe-onboarding-7.jpg",
    description:
        "Cook confidently with detailed instructions, photos, and videos guiding you through every recipe.",
  ),
  OnBoardingScreenRecipe(
    title: "Share with Friends",
    image: "assets/recipes/recipe-onboarding-6.jpg",
    description:
        "Share your favorite recipes and cooking experiences with family and friends effortlessly.",
  ),
  OnBoardingScreenRecipe(
    title: "Plan Your Week’s Meals",
    image: "assets/recipes/recipe-onboarding-1.png",
    description:
        "Bookmark your favorite recipes to access anytime. Organize them in custom collections for easy reference",
  ),
  OnBoardingScreenRecipe(
    title: "Smart Grocery Shopping",
    image: "assets/recipes/recipe-onboarding-2.png",
    description:
        "Get a ready-made shopping list for the entire week. Save time, money, and effort at the store.",
  ),
  OnBoardingScreenRecipe(
    title: "Healthy Meals, Made Easy",
    image: "assets/recipes/recipe-onboarding-3.png",
    description:
        "Prepare nutritious, delicious meals in about 30 minutes—perfect for any lifestyle or schedule.",
  ),
];

List<Map<String, dynamic>> cuisines = [
  {
    'name': 'All',
    'image': Image.asset("assets/recipes/all.png"),
  },
  {
    'name': 'Asian',
    'image': Image.asset("assets/recipes/asian.png"),
  },
  {
    'name': 'American',
    'image': Image.asset("assets/recipes/american.png"),
  },
  {
    'name': 'Brazilian',
    'image': Image.asset("assets/recipes/brazilian.png"),
  },
  {
    'name': 'Greek',
    'image': Image.asset("assets/recipes/greek.png"),
  },
  {
    'name': 'Italian',
    'image': Image.asset("assets/recipes/italian.png"),
  },
  {
    'name': 'Indian',
    'image': Image.asset("assets/recipes/indian.png"),
  },
  {
    'name': 'Japanese',
    'image': Image.asset("assets/recipes/japanese.png"),
  },
  {
    'name': 'Korean',
    'image': Image.asset("assets/recipes/korean.png"),
  },
  {
    'name': 'Lebanese',
    'image': Image.asset("assets/recipes/lebanese.png"),
  },
  {
    'name': 'Levantine',
    'image': Image.asset("assets/recipes/mediterranean.png"),
  },
  {
    'name': 'Mexican',
    'image': Image.asset("assets/recipes/mexican.png"),
  },
  {
    'name': 'Moroccan',
    'image': Image.asset("assets/recipes/moroccan.png"),
  },
  {
    'name': 'Pakistani',
    'image': Image.asset("assets/recipes/pakistani.png"),
  },
  {
    'name': 'Russian',
    'image': Image.asset("assets/recipes/russian.png"),
  },
  {
    'name': 'Smoothie',
    'image': Image.asset("assets/recipes/smoothie.png"),
  },
  {
    'name': 'Turkish',
    'image': Image.asset("assets/recipes/turkish.png"),
  },
  {
    'name': 'Thai',
    'image': Image.asset("assets/recipes/thai.png"),
  },
];
