import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/core/models/food_item.dart';
import 'package:healthy_food_ui/presentation/food_detail_screen.dart';
import 'package:healthy_food_ui/presentation/home_screen.dart';
import 'package:healthy_food_ui/presentation/onboarding_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.onboarding.routeName,
  routes: [
    GoRoute(path: NamedRoutes.onboarding.routeName, builder: (ctx, state) => const OnboardingScreen()),
    GoRoute(
      path: NamedRoutes.home.routeName,
      pageBuilder: (ctx, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionDuration: Duration(milliseconds: NumberConstant.animPageTransitionMs),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween(begin: Offset(0, NumberConstant.animPageSlideY), end: Offset.zero).animate(curved),
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: NamedRoutes.foodDetail.routeName,
      builder: (ctx, state) => FoodDetailScreen(item: state.extra as FoodItem),
    ),
  ],
);

enum NamedRoutes {
  onboarding('/onboarding'),
  home('/home'),
  foodDetail('/food-detail');

  final String routeName;
  const NamedRoutes(this.routeName);
}
