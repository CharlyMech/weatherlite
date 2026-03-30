import 'package:flutter/material.dart';
import 'package:weatherlite/core/theme/app_colors_extension.dart';

extension ThemeX on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
