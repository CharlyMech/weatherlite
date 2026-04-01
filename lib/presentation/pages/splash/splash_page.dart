import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/core/utils/weather_code_utils.dart';
import 'package:weatherlite/presentation/blocs/splash/splash_cubit.dart';
import 'package:weatherlite/presentation/blocs/splash/splash_state.dart';
import 'package:weatherlite/core/debug/debug_panel.dart';
import 'package:weatherlite/presentation/widgets/common/animated_dots_loader.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _appVersion = '';
  bool _minTimeElapsed = false;

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _startMinTimer();
    context.read<SplashCubit>().initialize();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() => _appVersion = 'v${info.version}');
    }
  }

  void _startMinTimer() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() => _minTimeElapsed = true);
        _tryNavigate();
      }
    });
  }

  void _tryNavigate() {
    final state = context.read<SplashCubit>().state;
    if (!state.isReady || !_minTimeElapsed) return;

    if (state.isFirstLaunch) {
      context.go(AppRoutes.onboarding);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;
    final splashImage = isDark
        ? 'assets/splash/dark_splash.png'
        : 'assets/splash/light_splash.png';
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isReady) _tryNavigate();
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              splashImage,
              fit: BoxFit.cover,
              errorBuilder: (_, e, st) =>
                  Container(color: Theme.of(context).scaffoldBackgroundColor),
            ),
            // Content overlay
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: 48 + MediaQuery.of(context).padding.top),
                  // ── Weather brief (top) ─────────────────────────────────
                  BlocBuilder<SplashCubit, SplashState>(
                    buildWhen: (prev, curr) =>
                        prev.weatherData != curr.weatherData,
                    builder: (context, state) {
                      final data = state.weatherData;
                      if (data == null) return const SizedBox.shrink();
                      return Column(
                        children: [
                          Text(
                            'Current Location',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: onSurface.withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${data.temperature.round()}°',
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(color: onSurface),
                          ),
                          Text(
                            WeatherCodeUtils.description(data.weatherCode),
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: onSurface.withValues(alpha: 0.8),
                                ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  // ── Branding (center-ish) ───────────────────────────────
                  Text(
                    'Weatherlite',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A Weather App simplified, fully customizable.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  // ── Loading indicator (near bottom) ─────────────────────
                  Text(
                    'Syncing data',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedDotsLoader(color: onSurface.withValues(alpha: 0.8)),
                  const SizedBox(height: 32),
                  // ── Version (bottom) ────────────────────────────────────
                  Text(
                    _appVersion,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            // ── Debug panel (debug builds only) ────────────────────────
            Positioned(bottom: 80, right: 16, child: const DebugPanel()),
          ],
        ),
      ),
    );
  }
}
