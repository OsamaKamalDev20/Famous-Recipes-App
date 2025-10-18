import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/json/recipes_onboarding_data.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/models/famous_recipes_models.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/screens/famous_recipes_details.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/screens/famous_recipes_lists.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/screens/popular_recipes_details.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/screens/popular_recipes_lists.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/services/recipes_services.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/themes/recipe_colors.dart';

import '../models/popular_recipes_models.dart';

class RecipesHomeScreen extends StatefulWidget {
  const RecipesHomeScreen({super.key});

  @override
  State<RecipesHomeScreen> createState() => _RecipesHomeScreenState();
}

class _RecipesHomeScreenState extends State<RecipesHomeScreen> {
  int selectedCuisines = 0;
  final ScrollController _scrollController = ScrollController();
  late Future<List<FamousRecipes>> _famousRecipesFuture;
  late Future<PopularRecipes> _popularRecipesFuture;

  @override
  void initState() {
    super.initState();
    _famousRecipesFuture = FamousRecipesServices.fetchFamousRecipes();
    _popularRecipesFuture = PopularRecipesServices.fetchPopularRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: recipeAppbar(),
      backgroundColor: recipeBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Heading Section
              recipesHeadings(),
              const SizedBox(height: 20),
              // Recipe Search Box
              recipeSearchBox(),
              SizedBox(height: 20),
              Text(
                'Most Popular Cuisines',
                style: heading.copyWith(fontSize: 20),
              ),
              SizedBox(height: 10),
              recipesCuisines(),
              SizedBox(height: 30),
              // Famous Recipes List
              FadeInLeft(
                delay: const Duration(milliseconds: 1500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Famous Recipes",
                      style: heading.copyWith(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FamousRecipesLists(),
                          ),
                        );
                      },
                      child: Text(
                        "view all",
                        style: description.copyWith(
                          fontSize: 15,
                          color: recipePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: _famousRecipesFuture,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: recipePrimary,
                      ),
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
                  final famousRecipe = snapshot.data!;
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        final famRecipe = famousRecipe[index];
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
                              width: 180,
                              margin: const EdgeInsets.only(right: 20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  .reverse[famRecipe.cuisine]!
                                                  .isEmpty
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
                      }),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Popular Recipes List
              FadeInLeft(
                delay: const Duration(milliseconds: 1500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Recipes",
                      style: heading.copyWith(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PopularRecipesLists(),
                          ),
                        );
                      },
                      child: Text(
                        "view all",
                        style: description.copyWith(
                          fontSize: 15,
                          color: recipePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<PopularRecipes>(
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
                  } else if (!snapshot.hasData ||
                      snapshot.data!.recipes.isEmpty) {
                    return Center(
                      child: Text(
                        "No popular recipes found",
                        style: subHeading.copyWith(fontSize: 16),
                      ),
                    );
                  }
                  final popular = snapshot.data!.recipes;
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
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
                              width: 180,
                              margin: const EdgeInsets.only(right: 20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          popRecipe.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: heading.copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Text(
                                              popRecipe.cuisine,
                                              style: subHeading.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FadeInUp recipesCuisines() {
    return FadeInUp(
      delay: const Duration(milliseconds: 1500),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(right: 16),
          itemCount: cuisines.length,
          itemBuilder: ((context, index) {
            final cuisine = cuisines[index];
            final bool isSelected = selectedCuisines == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCuisines = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? recipePrimary : Colors.grey[50],
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: isSelected ? recipePrimary : recipeLightBorder,
                          width: 1,
                        ),
                      ),
                      child: cuisine['image'],
                    ),
                    SizedBox(height: 8),
                    Text(
                      cuisine['name'],
                      textAlign: TextAlign.center,
                      style: heading.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  FadeInRight recipeSearchBox() {
    return FadeInRight(
      delay: Duration(milliseconds: 1000),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey.withOpacity(.1), width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              size: 22,
              color: recipeHeadingColor.withOpacity(.6),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                cursorColor: recipePrimary,
                style: description.copyWith(color: recipeHeadingColor),
                decoration: InputDecoration(
                  hintText: "Search any recipes",
                  hintStyle: description.copyWith(
                    color: recipeHeadingColor.withOpacity(.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: recipeCard,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(.1),
                  ),
                ],
              ),
              child: Icon(
                CupertinoIcons.slider_horizontal_3,
                color: recipeHeadingColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column recipesHeadings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          delay: Duration(milliseconds: 1000),
          child: Text(
            'Hi, Osama',
            style: description.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        FadeInRight(
          delay: Duration(milliseconds: 1000),
          child: RichText(
            text: TextSpan(
              text: 'Make your own food, \nstay at ',
              style: heading.copyWith(fontSize: 24),
              children: [
                TextSpan(
                  text: ' home',
                  style: heading.copyWith(fontSize: 24, color: recipePrimary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  AppBar recipeAppbar() {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: recipeBackground,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/recipes/profile.png",
            fit: BoxFit.cover,
            height: 80,
            width: 80,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.notifications_outlined,
                  size: 35,
                  color: recipeHeadingColor,
                ),
              ),
              Positioned(
                right: 2,
                top: -1,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: recipeButton,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2', // badge count
                    style:
                        description.copyWith(fontSize: 12, color: recipeCard),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
