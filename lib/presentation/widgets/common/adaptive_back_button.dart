import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconoir_flutter/regular/nav_arrow_left.dart' as iconoir_nav;
import 'package:iconoir_flutter/regular/arrow_left.dart' as iconoir_arrow;

class AdaptiveBackButton extends StatelessWidget {
  const AdaptiveBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isApple =
        Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.macOS;

    final color = Theme.of(context).colorScheme.onSurface;

    return IconButton(
      onPressed: () => context.pop(),
      icon: isApple
          ? iconoir_nav.NavArrowLeft(color: color, width: 24, height: 24)
          : iconoir_arrow.ArrowLeft(color: color, width: 24, height: 24),
    );
  }
}
