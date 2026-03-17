import 'package:go_router/go_router.dart';
import 'package:weatherlite/presentation/pages/home/home_page.dart';

/// Named route paths — use these constants everywhere instead of raw strings.
abstract final class AppRoutes {
  static const home = '/';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
