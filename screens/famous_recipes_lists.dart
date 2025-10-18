import 'package:flutter/material.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/themes/recipe_colors.dart';
import '../models/famous_recipes_models.dart';
import '../services/recipes_services.dart';
import 'famous_recipes_details.dart'; // ✅ import your service

class FamousRecipesLists extends StatefulWidget {
  const FamousRecipesLists({super.key});

  @override
  State<FamousRecipesLists> createState() => _FamousRecipesListsState();
}

class _FamousRecipesListsState extends State<FamousRecipesLists> {
  late Future<List<FamousRecipes>> _famousRecipesFuture;

  @override
  void initState() {
    super.initState();
    _famousRecipesFuture = FamousRecipesServices.fetchFamousRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeBackground,
      appBar: AppBar(
        backgroundColor: recipeBackground,
        title: Text(
          'Famous Recipes',
          style: heading.copyWith(color: recipeHeadingColor),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<List<FamousRecipes>>(
            future: _famousRecipesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: recipePrimary),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: subHeading.copyWith(fontSize: 16),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No famous recipes found",
                    style: subHeading.copyWith(fontSize: 16),
                  ),
                );
              }
              final famousRecipes = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.54,
                ),
                itemCount: famousRecipes.length,
                itemBuilder: (context, index) {
                  final famRecipe = famousRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              FamousRecipesDetails(fRecipe: famRecipe),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "famRecipe_${famRecipe.id}_${index}",
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Recipe Images ---
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    famRecipe.photoUrl,
                                    width: double.infinity,
                                    height: 240,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) =>
                                        Container(
                                      height: 240,
                                      width: double.infinity,
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.broken_image_rounded,
                                        size: 40,
                                        color: recipePrimary,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.schedule_rounded,
                                          color: recipeCard,
                                          size: 15,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${famRecipe.cookTime} mins",
                                          textAlign: TextAlign.center,
                                          style: description.copyWith(
                                            fontSize: 12,
                                            color: recipeCard,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 5,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                        color: recipePrimary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.schedule_rounded,
                                          color: recipeHeadingColor,
                                          size: 15,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "4.5",
                                          textAlign: TextAlign.center,
                                          style: description.copyWith(
                                            fontSize: 12,
                                            color: recipeHeadingColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // --- Title & Cuisine ---
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    famRecipe.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: heading.copyWith(fontSize: 16),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    cuisineValues
                                            .reverse[famRecipe.cuisine]!.isEmpty
                                        ? "Unknown Cuisine"
                                        : cuisineValues
                                            .reverse[famRecipe.cuisine]!,
                                    style: subHeading.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
