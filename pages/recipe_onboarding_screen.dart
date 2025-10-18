import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/json/recipes_onboarding_data.dart';
import 'package:flutter_ui_designs/Famous%20Recipes%20App/themes/recipe_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/recipes_home_screen.dart';

class RecipeOnBoardingScreen extends StatefulWidget {
  const RecipeOnBoardingScreen({super.key});

  @override
  State<RecipeOnBoardingScreen> createState() => _RecipeOnBoardingScreenState();
}

class _RecipeOnBoardingScreenState extends State<RecipeOnBoardingScreen>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  PageController recipeController = PageController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    recipeController = PageController(initialPage: 0);
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  void _resetAndStartAnimations() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    recipeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: recipeBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Skip Button Row
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipesHomeScreen(),
                    ),
                  );
                },
                child: Text(
                  "Skip",
                  style: description.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: recipePrimary,
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: recipeController,
                itemCount: recipes.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                    _resetAndStartAnimations();
                  });
                },
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated image container
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: Hero(
                                tag: "recipes_${recipes[index].image}",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              recipePrimary.withOpacity(0.18),
                                          blurRadius: 24,
                                          offset: Offset(0, 12),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      recipes[index].image,
                                      fit: BoxFit.cover,
                                      height: 250,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Title with animated container
                            SizedBox(height: 20),
                            FadeInLeft(
                              delay: Duration(milliseconds: 1200),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: recipePrimary.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: recipePrimary,
                                    width: 1.4,
                                  ),
                                ),
                                child: Text(
                                  recipes[index].title,
                                  textAlign: TextAlign.center,
                                  style: heading.copyWith(
                                    color: recipeHeadingColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            FadeInUp(
                              delay: Duration(milliseconds: 1200),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: recipeCard,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: recipeLightBorder, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: recipePrimary.withOpacity(0.10),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  recipes[index].description,
                                  textAlign: TextAlign.center,
                                  style: description,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Page indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SmoothPageIndicator(
                controller: recipeController,
                count: recipes.length,
                onDotClicked: (currentIndex) {
                  recipeController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 850),
                    curve: Curves.easeInOut,
                  );
                },
                effect: CustomizableEffect(
                  spacing: 8.0,
                  dotDecoration: DotDecoration(
                    width: 16,
                    height: 8,
                    color: recipeSecondary.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  activeDotDecoration: DotDecoration(
                    width: 40,
                    height: 8,
                    color: recipePrimary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            // Enhanced button
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(
                top: 0,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [recipePrimary, recipePrimary.withOpacity(0.8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (currentPage == recipes.length - 1) {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipesHomeScreen(),
                        ),
                      );
                    } else {
                      recipeController.nextPage(
                        duration: Duration(milliseconds: 850),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentPage == recipes.length - 1
                            ? "Get's Started"
                            : "Continue",
                        style: subHeading.copyWith(
                          fontSize: 20,
                          color: recipeHeadingColor,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.restaurant_menu,
                        color: recipeHeadingColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
