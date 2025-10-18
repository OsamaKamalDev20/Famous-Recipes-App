import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/models/famous_recipes_models.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/themes/recipe_colors.dart';

class FamousRecipesDetails extends StatelessWidget {
  final FamousRecipes fRecipe;
  const FamousRecipesDetails({super.key, required this.fRecipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeBackground,
      body: CustomScrollView(
        slivers: [
          recipeImage(context),
          recipeDetails(),
        ],
      ),
      bottomNavigationBar: recipeBottomNavbar(),
    );
  }

  SliverToBoxAdapter recipeDetails() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title, Cuisine and ratings
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeHeading(),
            ),

            // Recipes Description
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeDescription(),
            ),

            // Recipes Timings
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeTime(),
            ),

            // Main Ingredients
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeMainIngredients(),
            ),

            // Main Course
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeCourse(),
            ),

            //Ingredients
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeIngredients(),
            ),

            //Instructions
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeInstruction(),
            ),

            //Minerals
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: mineralsRecipe(),
            ),

            //Servings and Yields
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeYieldAndServings(),
            ),

            //Tags
            const SizedBox(height: 20),
            FadeInLeft(
              delay: const Duration(milliseconds: 1500),
              child: recipeTags(),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar recipeImage(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 260,
      backgroundColor: recipePrimary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'famRecipe_${fRecipe.id}',
              child: Image.network(
                fRecipe.photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) =>
                    Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image_rounded,
                    size: 100,
                    color: recipePrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: recipeCard,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: recipeCard,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.heart_fill,
              size: 24,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  SafeArea recipeBottomNavbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_rounded,
                size: 30, color: recipeHeadingColor),
            label: Text(
              "Order Now",
              style: heading.copyWith(
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: recipePrimary),
          ),
        ),
      ),
    );
  }

  Column recipeInstruction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Instructions",
              style: heading.copyWith(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Image.asset(
              "assets/recipes/instructions.png",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          fRecipe.directions,
          style: description,
        ),
      ],
    );
  }

  Column recipeIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ingredients",
              style: heading.copyWith(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Image.asset(
              "assets/recipes/ingredients.png",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          fRecipe.ingredients,
          style: description,
        ),
      ],
    );
  }

  Column recipeCourse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          fRecipe.course.isEmpty ? "No main course mentioned." : fRecipe.course,
          style: description,
        ),
      ],
    );
  }

  Column recipeMainIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Main Ingredient",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          fRecipe.mainIngredient.isEmpty
              ? "No main ingredient in ${fRecipe.title}"
              : fRecipe.mainIngredient,
          style: description,
        ),
      ],
    );
  }

  Column recipeDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descriptions",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Text(
          fRecipe.description.isEmpty
              ? "No description provided in APIs"
              : fRecipe.description,
          textAlign: TextAlign.justify,
          style: description,
        ),
      ],
    );
  }

  Row recipeHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fRecipe.title,
                maxLines: 2,
                style: heading,
              ),
              const SizedBox(height: 4),
              Text(
                cuisineValues.reverse[fRecipe.cuisine]!.isEmpty
                    ? "Unknown Cuisine"
                    : cuisineValues.reverse[fRecipe.cuisine]!,
                style: subHeading.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: recipePrimary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.star_rate_rounded,
                color: recipeHeadingColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text("4.5", style: heading.copyWith(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  Column recipeTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Timing's",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              recipeTimings(
                "assets/recipes/prepTime.png",
                "Prep Time",
                fRecipe.prepTime.toString(),
                "mins",
              ),
              recipeTimings(
                "assets/recipes/cookTime.png",
                "Cook Time",
                fRecipe.cookTime.toString(),
                "mins",
              ),
              recipeTimings(
                "assets/recipes/totalTime.png",
                "Total Time",
                fRecipe.totalTime.toString(),
                "mins",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container recipeTimings(String image, title, value, subTitle) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: recipeCard,
        border: Border.all(width: 1, color: recipeLightBorder),
        boxShadow: [
          BoxShadow(
            color: recipePrimary.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: subHeading.copyWith(fontSize: 14, color: recipeHeadingColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: heading.copyWith(fontSize: 26, color: recipePrimary),
          ),
          Text(
            subTitle,
            style: description.copyWith(
              color: recipeDescriptionColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Container recipesMinerals(String image, value, String label) {
    // Handle null, empty string, or invalid values
    final displayValue =
        (value == null || value.toString().isEmpty) ? "N/A" : value.toString();
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: recipeCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: recipePrimary.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(6),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(displayValue, style: subHeading),
          const SizedBox(height: 4),
          Text(label, style: description.copyWith(fontSize: 14)),
        ],
      ),
    );
  }

  Column mineralsRecipe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Minerals",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            recipesMinerals(
              "assets/recipes/calories.png",
              fRecipe.calories,
              "Calories",
            ),
            recipesMinerals(
              "assets/recipes/fat.png",
              fRecipe.fat,
              "Fats",
            ),
            recipesMinerals(
              "assets/recipes/cholesterol.png",
              fRecipe.cholesterol,
              "Cholesterol",
            ),
            recipesMinerals(
              "assets/recipes/sodium.png",
              fRecipe.sodium,
              "Sodium",
            ),
            recipesMinerals(
              "assets/recipes/sugar.png",
              fRecipe.sugar,
              "Sugar",
            ),
            recipesMinerals(
              "assets/recipes/carbohydrate.png",
              fRecipe.carbohydrate,
              "Carbohydrate.png",
            ),
            recipesMinerals(
              "assets/recipes/fiber.png",
              fRecipe.fiber,
              "Fiber",
            ),
            recipesMinerals(
              "assets/recipes/protein.png",
              fRecipe.protein,
              "Protein",
            ),
          ],
        ),
      ],
    );
  }

  Container recipeServings(String image, title, value) {
    final displayValue = value.toString().isEmpty ? "N/A" : value.toString();
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: recipeCard,
        border: Border.all(width: 1, color: recipeLightBorder),
        boxShadow: [
          BoxShadow(
            color: recipePrimary.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: subHeading.copyWith(fontSize: 14, color: recipeHeadingColor),
          ),
          const SizedBox(height: 6),
          Text(
            displayValue,
            style: heading.copyWith(fontSize: 20, color: recipePrimary),
          ),
        ],
      ),
    );
  }

  Column recipeYieldAndServings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Servings and Yields",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recipeServings(
              "assets/recipes/servings.png",
              "Servings",
              fRecipe.servings,
            ),
            recipeServings(
              "assets/recipes/yield.png",
              "Yields",
              fRecipe.famousRecipeYield,
            ),
          ],
        ),
      ],
    );
  }

  Column recipeTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recipes Tags",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          fRecipe.tags.isEmpty ? "No tags in ${fRecipe.title}" : fRecipe.tags,
          style: description,
        ),
      ],
    );
  }
}
