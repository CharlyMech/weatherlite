import 'package:flutter/material.dart';
import 'package:weatherlite/core/theme/app_colors_extension.dart';

extension ThemeX on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  /// Glass-morphism card tint — white at low alpha on dark, surface at low alpha on light.
  Color get glassColor =>
      Theme.of(this).colorScheme.surface.withValues(alpha: 0.18);
}
