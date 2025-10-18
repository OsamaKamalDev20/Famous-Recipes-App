import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/models/popular_recipes_models.dart';

import '../themes/recipe_colors.dart';

class PopularRecipesDetails extends StatelessWidget {
  final Recipe pRecipe;
  const PopularRecipesDetails({super.key, required this.pRecipe});

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
        bottomNavigationBar: recipeBottomNavbar());
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
              child: recipeHeading(pRecipe.name, pRecipe.cuisine,
                  pRecipe.rating, pRecipe.reviewCount),
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
              child: recipeInstructions(),
            ),

            // Recipes Timings
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeTime(),
            ),

            // Recipes Servings
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeYieldAndServings(),
            ),

            // Recipes Tags
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeTags(),
            ),

            // Recipes Meals Types
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              child: recipeMealType(),
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
              tag: 'famRecipe_${pRecipe.id}',
              child: Image.network(
                pRecipe.image,
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

  Row recipeHeading(String title, subTitle, ratings, reviews) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: heading,
              ),
              const SizedBox(height: 4),
              Text(
                subTitle,
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
              Text(ratings.toString(), style: heading.copyWith(fontSize: 14)),
              const SizedBox(width: 4),
              Text(
                "(${reviews.toString()} reviews)",
                style: heading.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column recipeInstructions() {
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
        Column(
          children: List.generate(
            pRecipe.instructions.length,
            (index) {
              final step = pRecipe.instructions[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step bullet
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: recipePrimary,
                      ),
                    ),

                    // Step text
                    Expanded(
                      child: Text(
                        step.isEmpty ? "Instruction not available." : step,
                        textAlign: TextAlign.justify,
                        style: description,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
        Column(
          children: List.generate(
            pRecipe.ingredients.length,
            (index) {
              final step = pRecipe.ingredients[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step bullet
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: recipePrimary,
                      ),
                    ),

                    // Step text
                    Expanded(
                      child: Text(
                          step.isEmpty ? "Ingredients not available." : step,
                          textAlign: TextAlign.justify,
                          style: description),
                    ),
                  ],
                ),
              );
            },
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              recipeTimings(
                "assets/recipes/prepTime.png",
                "Prep Time",
                pRecipe.prepTimeMinutes.toString(),
                "mins",
              ),
              recipeTimings(
                "assets/recipes/cookTime.png",
                "Cook Time",
                pRecipe.cookTimeMinutes.toString(),
                "mins",
              ),
              recipeTimings(
                "assets/recipes/totalTime.png",
                "Total Time",
                ((pRecipe.cookTimeMinutes) + (pRecipe.prepTimeMinutes))
                    .toString(),
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

  Container recipeServings(String image, title, value) {
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
            value.toString(),
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
          "Servings and Calories",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              recipeServings(
                "assets/recipes/servings.png",
                "Servings",
                pRecipe.servings,
              ),
              recipeServings(
                "assets/recipes/calories.png",
                "Calories",
                "${pRecipe.caloriesPerServing} kcal",
              ),
              recipeServings(
                "assets/recipes/difficulty.png",
                "Difficulty",
                pRecipe.difficulty.name,
              ),
            ],
          ),
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
        const SizedBox(height: 10),
        Column(
          children: List.generate(
            pRecipe.tags.length,
            (index) {
              final step = pRecipe.tags[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step bullet
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: recipePrimary,
                      ),
                    ),

                    // Step text
                    Expanded(
                      child: Text(
                        step.isEmpty ? "Recipes Tags not available." : step,
                        textAlign: TextAlign.justify,
                        style: description,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column recipeMealType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recipe Meals Type",
          style: heading.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(
            pRecipe.mealType.length,
            (index) {
              final step = pRecipe.mealType[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step bullet
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: recipePrimary,
                      ),
                    ),

                    // Step text
                    Expanded(
                      child: Text(
                        step.isEmpty
                            ? "Recipes Meal Type not available."
                            : step,
                        textAlign: TextAlign.justify,
                        style: description,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
