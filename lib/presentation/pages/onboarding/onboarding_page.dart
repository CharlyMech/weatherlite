import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/data/repositories/location_repository_impl.dart';
import 'package:weatherlite/data/repositories/weather_repository_impl.dart';
import 'package:weatherlite/presentation/blocs/location/locations_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_event.dart';
import 'package:weatherlite/presentation/blocs/onboarding/onboarding_cubit.dart';
import 'package:weatherlite/presentation/blocs/onboarding/onboarding_state.dart';
import 'package:weatherlite/presentation/pages/onboarding/pages/customization_page_content.dart';
import 'package:weatherlite/presentation/pages/onboarding/pages/get_started_page_content.dart';
import 'package:weatherlite/presentation/pages/onboarding/pages/permissions_page_content.dart';
import 'package:weatherlite/presentation/pages/onboarding/pages/welcome_page_content.dart';
import 'package:weatherlite/presentation/widgets/layout/city_page_indicator.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;
    final bgImage = isDark
        ? 'assets/splash/dark_splash.png'
        : 'assets/splash/light_splash.png';

    return BlocProvider(
      create: (_) => OnboardingCubit(
        appPrefs: context.read<AppPreferences>(),
        locationRepo: context.read<LocationRepositoryImpl>(),
        weatherRepo: context.read<WeatherRepositoryImpl>(),
      ),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (prev, curr) => !prev.isComplete && curr.isComplete,
        listener: (context, state) {
          context.read<LocationsBloc>().add(LoadLocations());
          context.go(AppRoutes.home);
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                bgImage,
                fit: BoxFit.cover,
                errorBuilder: (_, e, st) => Container(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              // Content
              Positioned.fill(
                child: Column(
                  children: [
                    // ── Top nav row ───────────────────────────────────────
                    _TopNavRow(
                      onSkip: () => _animateToPage(3),
                      onNext: () {},
                      pageController: _pageController,
                    ),
                    // ── Pages ─────────────────────────────────────────────
                    Expanded(
                      child: BlocConsumer<OnboardingCubit, OnboardingState>(
                        listenWhen: (prev, curr) =>
                            prev.currentPage != curr.currentPage,
                        listener: (context, state) {
                          if (_pageController.hasClients &&
                              _pageController.page?.round() !=
                                  state.currentPage) {
                            _animateToPage(state.currentPage);
                          }
                        },
                        builder: (context, state) {
                          return PageView(
                            controller: _pageController,
                            onPageChanged: (page) {
                              context.read<OnboardingCubit>().goToPage(page);
                            },
                            children: const [
                              WelcomePageContent(),
                              PermissionsPageContent(),
                              CustomizationPageContent(),
                              GetStartedPageContent(),
                            ],
                          );
                        },
                      ),
                    ),
                    // ── Page indicator ────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: BlocBuilder<OnboardingCubit, OnboardingState>(
                        buildWhen: (prev, curr) =>
                            prev.currentPage != curr.currentPage,
                        builder: (context, state) {
                          return CityPageIndicator(
                            count: state.totalPages,
                            currentIndex: state.currentPage,
                          );
                        },
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
  }
}

class _TopNavRow extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final PageController pageController;

  const _TopNavRow({
    required this.onSkip,
    required this.onNext,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (prev, curr) => prev.currentPage != curr.currentPage,
      builder: (context, state) {
        final isLastPage = state.currentPage == state.totalPages - 1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip button
              Opacity(
                opacity: isLastPage ? 0 : 1,
                child: IgnorePointer(
                  ignoring: isLastPage,
                  child: TextButton(
                    onPressed: onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              // Next button
              Opacity(
                opacity: isLastPage ? 0 : 1,
                child: IgnorePointer(
                  ignoring: isLastPage,
                  child: TextButton(
                    onPressed: () {
                      context.read<OnboardingCubit>().nextPage();
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
