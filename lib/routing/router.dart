import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/presentation/onboarding_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.onboarding.routeName,
  routes: [
    GoRoute(path: NamedRoutes.onboarding.routeName, builder: (ctx, state)=> OnboardingScreen())
  ],
);

enum NamedRoutes {
  onboarding('/onboaring');
  
  final String routeName;
  const NamedRoutes(this.routeName);
}