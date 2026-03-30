import 'package:flutter/material.dart';

class AnimatedDotsLoader extends StatefulWidget {
  final Color? color;
  final double dotSize;
  final double spacing;

  const AnimatedDotsLoader({
    super.key,
    this.color,
    this.dotSize = 8,
    this.spacing = 6,
  });

  @override
  State<AnimatedDotsLoader> createState() => _AnimatedDotsLoaderState();
}

class _AnimatedDotsLoaderState extends State<AnimatedDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ??
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final begin = index * 0.2;
        final end = begin + 0.4;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final opacity = _Tween(begin: 0.3, end: 1.0)
                .evaluate(_curvedAnimation(begin, end));
            final scale = _Tween(begin: 0.8, end: 1.0)
                .evaluate(_curvedAnimation(begin, end));
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: widget.dotSize,
                    height: widget.dotSize,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Animation<double> _curvedAnimation(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin.clamp(0, 1), end.clamp(0, 1), curve: Curves.easeInOut),
    );
  }
}

class _Tween {
  final double begin;
  final double end;
  const _Tween({required this.begin, required this.end});

  double evaluate(Animation<double> animation) {
    return begin + (end - begin) * animation.value;
  }
}
