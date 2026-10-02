import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/presentation/home_screen.dart';
import 'package:healthy_food_ui/presentation/onboarding_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.onboarding.routeName,
  routes: [
    GoRoute(path: NamedRoutes.onboarding.routeName, builder: (ctx, state) => const OnboardingScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
  ],
);

enum NamedRoutes {
  onboarding('/onboarding'),
  home('/home');

  final String routeName;
  const NamedRoutes(this.routeName);
}
