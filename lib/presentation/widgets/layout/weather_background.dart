import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors_extension.dart';

class WeatherBackground extends StatefulWidget {
  final int weatherCode;

  const WeatherBackground({super.key, required this.weatherCode});

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _WeatherCondition get _condition {
    final code = widget.weatherCode;
    if (code == 0 || code == 1) return _WeatherCondition.clear;
    if (code == 2 || code == 3) return _WeatherCondition.cloudy;
    if (code >= 51 && code <= 67) return _WeatherCondition.rain;
    if (code >= 71 && code <= 77) return _WeatherCondition.snow;
    if (code >= 80 && code <= 82) return _WeatherCondition.rain;
    if (code >= 95) return _WeatherCondition.rain;
    return _WeatherCondition.clear;
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<AppColorsExtension>();
    if (ext == null) return const SizedBox.expand();

    final bg = Theme.of(context).scaffoldBackgroundColor;
    final condition = _condition;
    final isNight = DateTime.now().hour < 6 || DateTime.now().hour > 20;

    List<Color> gradientColors;
    switch (condition) {
      case _WeatherCondition.clear:
        gradientColors = isNight
            ? [ext.nightTint, bg]
            : [ext.skyGradientTop, ext.skyGradientBottom];
      case _WeatherCondition.cloudy:
        gradientColors = [ext.skyGradientTop, bg];
      case _WeatherCondition.rain:
        gradientColors = [ext.rainTint, bg];
      case _WeatherCondition.snow:
        gradientColors = [ext.snowTint, bg];
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Animated gradient
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(
                    -1 + math.sin(t * math.pi * 2) * 0.3,
                    -1,
                  ),
                  end: Alignment(
                    1 + math.cos(t * math.pi * 2) * 0.3,
                    1,
                  ),
                  colors: gradientColors,
                ),
              ),
            ),
            // Subtle animated overlay for depth
            if (condition == _WeatherCondition.rain)
              _RainOverlay(animation: _controller),
            if (condition == _WeatherCondition.snow)
              _SnowOverlay(animation: _controller),
            if (condition == _WeatherCondition.clear && isNight)
              _StarOverlay(animation: _controller),
          ],
        );
      },
    );
  }
}

enum _WeatherCondition { clear, cloudy, rain, snow }

class _RainOverlay extends StatelessWidget {
  final AnimationController animation;

  const _RainOverlay({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _RainPainter(animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _RainPainter extends CustomPainter {
  final double t;
  _RainPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final rng = math.Random(42);
    for (int i = 0; i < 40; i++) {
      final x = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final y = (baseY + t * size.height * (0.8 + rng.nextDouble() * 0.4)) %
          size.height;
      canvas.drawLine(
        Offset(x, y),
        Offset(x - 2, y + 12),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RainPainter old) => old.t != t;
}

class _SnowOverlay extends StatelessWidget {
  final AnimationController animation;

  const _SnowOverlay({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _SnowPainter(animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _SnowPainter extends CustomPainter {
  final double t;
  _SnowPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.15);

    final rng = math.Random(42);
    for (int i = 0; i < 30; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final drift = math.sin(t * math.pi * 2 + i) * 15;
      final x = (baseX + drift) % size.width;
      final y = (baseY + t * size.height * 0.3) % size.height;
      final radius = 1.5 + rng.nextDouble() * 2;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(_SnowPainter old) => old.t != t;
}

class _StarOverlay extends StatelessWidget {
  final AnimationController animation;

  const _StarOverlay({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _StarPainter(animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _StarPainter extends CustomPainter {
  final double t;
  _StarPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(123);
    for (int i = 0; i < 25; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height * 0.6;
      final twinkle =
          (math.sin(t * math.pi * 2 + i * 0.7) * 0.5 + 0.5).clamp(0.2, 1.0);
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: twinkle * 0.3);
      canvas.drawCircle(Offset(x, y), 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => old.t != t;
}
