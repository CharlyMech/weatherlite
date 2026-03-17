import 'package:flutter/material.dart';

/// Defines the available theme types for the application.
enum ThemeType { light, dark, system }

/// Represents a custom theme configuration with all color definitions
/// needed for the application's visual styling.
///
/// Colors are stored as hex strings (e.g., '#RRGGBB') and parsed on demand.
/// The [extra] map allows adding weather-specific or domain-specific colors
/// that are not covered by Flutter's [ThemeData] / [ColorScheme] — these are
/// accessed by the settings BLoC and by widgets that need them directly.
class AppColors {
  // ── Core palette ──────────────────────────────────────────────────────────

  /// Primary brand / accent color (e.g. sky-blue highlight).
  final String primaryColor;

  /// Text / icon color on top of [primaryColor] backgrounds.
  final String onPrimaryColor;

  /// Main scaffold / background color.
  final String backgroundColor;

  /// Text / icon color on top of [backgroundColor].
  final String onBackgroundColor;

  /// Surface color for cards, sheets, bottom bars.
  final String surfaceColor;

  /// Text / icon color on top of [surfaceColor].
  final String onSurfaceColor;

  // ── Status colors ─────────────────────────────────────────────────────────

  /// Success / positive status (clear skies, good AQI, etc.).
  final String colorGreen;

  /// Error / critical status (storm warning, etc.).
  final String colorRed;

  /// Text / icon color on top of [colorRed] backgrounds.
  final String onRedColor;

  /// Warning status (moderate rain, haze, etc.).
  final String colorOrange;

  // ── Supporting colors ─────────────────────────────────────────────────────

  /// Inactive / disabled element color.
  final String inactiveColor;

  /// Text / icon color on top of [inactiveColor] backgrounds.
  final String onInactiveColor;

  /// Border and divider color.
  final String outlineColor;

  /// Shadow color for elevation effects.
  final String shadowColor;

  // ── Weather / domain-specific extra colors ────────────────────────────────
  //
  // These colors are NOT part of Flutter's ColorScheme but are required by
  // weather widgets and will be stored in the settings BLoC state so that
  // any widget tree can access them without a BuildContext theme lookup.

  /// Gradient start color for the sky background (top).
  final String skyGradientTop;

  /// Gradient end color for the sky background (bottom).
  final String skyGradientBottom;

  /// Color used to tint precipitation / rain indicators.
  final String rainTint;

  /// Color used to tint snow / ice indicators.
  final String snowTint;

  /// Color used for UV-index and sunshine indicators.
  final String sunTint;

  /// Color for night-mode sky / moon elements.
  final String nightTint;

  /// Subtle card overlay / glass-morphism tint.
  final String cardOverlay;

  const AppColors({
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.backgroundColor,
    required this.onBackgroundColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.colorGreen,
    required this.colorRed,
    required this.onRedColor,
    required this.colorOrange,
    required this.inactiveColor,
    required this.onInactiveColor,
    required this.outlineColor,
    required this.shadowColor,
    required this.skyGradientTop,
    required this.skyGradientBottom,
    required this.rainTint,
    required this.snowTint,
    required this.sunTint,
    required this.nightTint,
    required this.cardOverlay,
  });

  /// Parses a hex color string ('#RRGGBB' or '#AARRGGBB') into a [Color].
  Color parse(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xff')));

  // ── Convenience getters (parsed) ──────────────────────────────────────────

  Color get primary => parse(primaryColor);
  Color get onPrimary => parse(onPrimaryColor);
  Color get background => parse(backgroundColor);
  Color get onBackground => parse(onBackgroundColor);
  Color get surface => parse(surfaceColor);
  Color get onSurface => parse(onSurfaceColor);
  Color get green => parse(colorGreen);
  Color get red => parse(colorRed);
  Color get onRed => parse(onRedColor);
  Color get orange => parse(colorOrange);
  Color get inactive => parse(inactiveColor);
  Color get onInactive => parse(onInactiveColor);
  Color get outline => parse(outlineColor);
  Color get shadow => parse(shadowColor);
  Color get skyTop => parse(skyGradientTop);
  Color get skyBottom => parse(skyGradientBottom);
  Color get rain => parse(rainTint);
  Color get snow => parse(snowTint);
  Color get sun => parse(sunTint);
  Color get night => parse(nightTint);
  Color get card => parse(cardOverlay);
}

// ── Pre-configured themes ──────────────────────────────────────────────────

const Map<ThemeType, AppColors> appColorSchemes = {
  ThemeType.light: AppColors(
    primaryColor: '#4A90D9',
    onPrimaryColor: '#FFFFFF',
    backgroundColor: '#EEF4FB',
    onBackgroundColor: '#1A2A3A',
    surfaceColor: '#FFFFFF',
    onSurfaceColor: '#1A2A3A',
    colorGreen: '#3BAE70',
    colorRed: '#D64C4C',
    onRedColor: '#FFFFFF',
    colorOrange: '#F5A623',
    inactiveColor: '#C8D6E5',
    onInactiveColor: '#3A4A5A',
    outlineColor: '#D8E4F0',
    shadowColor: '#00000033',
    skyGradientTop: '#5BA8E8',
    skyGradientBottom: '#A8D4F5',
    rainTint: '#5B9FD4',
    snowTint: '#D4EAF7',
    sunTint: '#FFD166',
    nightTint: '#1A2F5E',
    cardOverlay: '#FFFFFF26',
  ),
  ThemeType.dark: AppColors(
    primaryColor: '#5BB8F5',
    onPrimaryColor: '#0A1929',
    backgroundColor: '#0A1929',
    onBackgroundColor: '#E8F1F8',
    surfaceColor: '#112240',
    onSurfaceColor: '#E8F1F8',
    colorGreen: '#4CC888',
    colorRed: '#E05C5C',
    onRedColor: '#FFFFFF',
    colorOrange: '#FFAB40',
    inactiveColor: '#1E3A5F',
    onInactiveColor: '#A0BDD4',
    outlineColor: '#1E3A5F',
    shadowColor: '#000000',
    skyGradientTop: '#0D2137',
    skyGradientBottom: '#1A4A7A',
    rainTint: '#3A7CB8',
    snowTint: '#B8D8EF',
    sunTint: '#FFD166',
    nightTint: '#050D1A',
    cardOverlay: '#FFFFFF0D',
  ),
};
