import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/presentation/pages/home/home_page.dart';
import 'package:weatherlite/presentation/pages/location/location_page.dart';
import 'package:weatherlite/presentation/pages/map/map_page.dart';
import 'package:weatherlite/presentation/pages/onboarding/onboarding_page.dart';
import 'package:weatherlite/presentation/pages/profile/profile_page.dart';
import 'package:weatherlite/presentation/pages/settings/settings_page.dart';
import 'package:weatherlite/presentation/pages/splash/splash_page.dart';
import 'package:weatherlite/presentation/widgets/layout/main_shell.dart';

/// Named route paths — use these constants everywhere instead of raw strings.
abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const homeLocation = '/home/:locationId';
  static const addCity = '/home/add-city';
  static const map = '/map';
  static const profile = '/profile';
  static const settings = '/settings';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    // Main shell — holds all primary destinations in a persistent layout
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'add-city',
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: const LocationPage(),
                  ),
                ),
                GoRoute(
                  path: ':locationId',
                  builder: (context, state) => HomePage(
                    initialLocationId: state.pathParameters['locationId'],
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.map,
              builder: (context, state) => const MapPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
