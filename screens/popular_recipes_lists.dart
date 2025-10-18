import 'package:flutter/material.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/themes/recipe_colors.dart';
import '../models/popular_recipes_models.dart';
import '../services/recipes_services.dart';
import 'popular_recipes_details.dart'; // ✅ import your service

class PopularRecipesLists extends StatefulWidget {
  const PopularRecipesLists({super.key});

  @override
  State<PopularRecipesLists> createState() => _PopularRecipesListsState();
}

class _PopularRecipesListsState extends State<PopularRecipesLists> {
  late Future<PopularRecipes> _popularRecipesFuture;

  @override
  void initState() {
    super.initState();
    _popularRecipesFuture = PopularRecipesServices.fetchPopularRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeBackground,
      appBar: AppBar(
        backgroundColor: recipeBackground,
        title: Text(
          'Popular Recipes',
          style: heading.copyWith(color: recipeHeadingColor),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<PopularRecipes>(
            future: _popularRecipesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: recipePrimary),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.recipes.isEmpty) {
                return Center(
                  child: Text(
                    "No popular recipes found",
                    style: subHeading.copyWith(fontSize: 16),
                  ),
                );
              }

              final popular = snapshot.data!.recipes;
              return GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.54,
                ),
                itemCount: popular.length,
                itemBuilder: (context, index) {
                  final popRecipe = popular[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PopularRecipesDetails(pRecipe: popRecipe),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "popRecipe_${popRecipe.id}_${index}",
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Recipe Image ---
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    popRecipe.image,
                                    width: double.infinity,
                                    height: 240,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) =>
                                        Container(
                                      height: 160,
                                      width: double.infinity,
                                      color: recipeBackground,
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
                                          "${popRecipe.cookTimeMinutes} mins",
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
                                          "${popRecipe.rating.toString()}",
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
                                    popRecipe.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: heading.copyWith(fontSize: 16),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    popRecipe.cuisine,
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
