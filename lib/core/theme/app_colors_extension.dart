import 'package:flutter/material.dart';

/// A [ThemeExtension] that exposes all custom app colors not covered by
/// Flutter's built-in [ColorScheme].
///
/// Register this in [ThemeData.extensions] so any widget can access it via:
/// ```dart
/// Theme.of(context).extension<AppColorsExtension>()!
/// ```
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  // ── Weather colors ──────────────────────────────────────────────────────
  final Color skyGradientTop;
  final Color skyGradientBottom;
  final Color rainTint;
  final Color snowTint;
  final Color sunTint;
  final Color nightTint;
  final Color cardOverlay;

  // ── Supporting colors ───────────────────────────────────────────────────
  final Color inactive;
  final Color onInactive;
  final Color outline;
  final Color shadow;

  // ── Status colors ───────────────────────────────────────────────────────
  final Color green;
  final Color onGreen;
  final Color orange;
  final Color onOrange;

  const AppColorsExtension({
    required this.skyGradientTop,
    required this.skyGradientBottom,
    required this.rainTint,
    required this.snowTint,
    required this.sunTint,
    required this.nightTint,
    required this.cardOverlay,
    required this.inactive,
    required this.onInactive,
    required this.outline,
    required this.shadow,
    required this.green,
    required this.onGreen,
    required this.orange,
    required this.onOrange,
  });

  @override
  AppColorsExtension copyWith({
    Color? skyGradientTop,
    Color? skyGradientBottom,
    Color? rainTint,
    Color? snowTint,
    Color? sunTint,
    Color? nightTint,
    Color? cardOverlay,
    Color? inactive,
    Color? onInactive,
    Color? outline,
    Color? shadow,
    Color? green,
    Color? onGreen,
    Color? orange,
    Color? onOrange,
  }) {
    return AppColorsExtension(
      skyGradientTop: skyGradientTop ?? this.skyGradientTop,
      skyGradientBottom: skyGradientBottom ?? this.skyGradientBottom,
      rainTint: rainTint ?? this.rainTint,
      snowTint: snowTint ?? this.snowTint,
      sunTint: sunTint ?? this.sunTint,
      nightTint: nightTint ?? this.nightTint,
      cardOverlay: cardOverlay ?? this.cardOverlay,
      inactive: inactive ?? this.inactive,
      onInactive: onInactive ?? this.onInactive,
      outline: outline ?? this.outline,
      shadow: shadow ?? this.shadow,
      green: green ?? this.green,
      onGreen: onGreen ?? this.onGreen,
      orange: orange ?? this.orange,
      onOrange: onOrange ?? this.onOrange,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      skyGradientTop: Color.lerp(skyGradientTop, other.skyGradientTop, t)!,
      skyGradientBottom:
          Color.lerp(skyGradientBottom, other.skyGradientBottom, t)!,
      rainTint: Color.lerp(rainTint, other.rainTint, t)!,
      snowTint: Color.lerp(snowTint, other.snowTint, t)!,
      sunTint: Color.lerp(sunTint, other.sunTint, t)!,
      nightTint: Color.lerp(nightTint, other.nightTint, t)!,
      cardOverlay: Color.lerp(cardOverlay, other.cardOverlay, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      onInactive: Color.lerp(onInactive, other.onInactive, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      green: Color.lerp(green, other.green, t)!,
      onGreen: Color.lerp(onGreen, other.onGreen, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      onOrange: Color.lerp(onOrange, other.onOrange, t)!,
    );
  }
}
