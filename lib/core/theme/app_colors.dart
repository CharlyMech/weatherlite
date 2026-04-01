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

  /// Primary brand / accent color.
  final String primaryColor;

  /// Text / icon color on top of [primaryColor] backgrounds.
  final String onPrimaryColor;

  /// Secondary brand.
  final String secondaryColor;

  /// Text / icon color on top of [secondaryColor] backgrounds.
  final String onSecondaryColor;

  /// Tertiary brand.
  final String tertiaryColor;

  /// Text / icon color on top of [tertiaryColor] backgrounds.
  final String onTertiaryColor;

  /// Neutral color.
  final String neutralColor;

  /// Text / icon color on top of [neutralolor] backgrounds.
  final String onNeutralColor;

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

  /// Text / icon color on top of [colorGreen] backgrounds.
  final String onGreenColor;

  /// Error / critical status (storm warning, etc.).
  final String colorRed;

  /// Text / icon color on top of [colorRed] backgrounds.
  final String onRedColor;

  /// Warning status (moderate rain, haze, etc.).
  final String colorOrange;

  /// Text / icon color on top of [colorOrange] backgrounds.
  final String onOrangeColor;

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

  const AppColors({
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.secondaryColor,
    required this.onSecondaryColor,
    required this.tertiaryColor,
    required this.onTertiaryColor,
    required this.neutralColor,
    required this.onNeutralColor,
    required this.backgroundColor,
    required this.onBackgroundColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.colorGreen,
    required this.onGreenColor,
    required this.colorRed,
    required this.onRedColor,
    required this.colorOrange,
    required this.onOrangeColor,
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
  });

  /// Parses a hex color string ('#RRGGBB' or '#AARRGGBB') into a [Color].
  Color parse(String hex) => Color(int.parse(hex.replaceFirst('#', '0xff')));

  // ── Convenience getters (parsed) ──────────────────────────────────────────

  Color get primary => parse(primaryColor);
  Color get onPrimary => parse(onPrimaryColor);
  Color get secondary => parse(secondaryColor);
  Color get onSecondary => parse(onSecondaryColor);
  Color get tertiary => parse(tertiaryColor);
  Color get onTertiary => parse(onTertiaryColor);
  Color get neutral => parse(neutralColor);
  Color get onNeutral => parse(onNeutralColor);
  Color get background => parse(backgroundColor);
  Color get onBackground => parse(onBackgroundColor);
  Color get surface => parse(surfaceColor);
  Color get onSurface => parse(onSurfaceColor);
  Color get green => parse(colorGreen);
  Color get onGreen => parse(onGreenColor);
  Color get red => parse(colorRed);
  Color get onRed => parse(onRedColor);
  Color get orange => parse(colorOrange);
  Color get onOrange => parse(onOrangeColor);
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
}

// ── Pre-configured themes ──────────────────────────────────────────────────

const Map<ThemeType, AppColors> appColorSchemes = {
  ThemeType.light: AppColors(
    primaryColor: '#FFFFFF',
    onPrimaryColor: '#1a1c1d',
    secondaryColor: '#F5f5f7',
    onSecondaryColor: '#1a1c1d',
    tertiaryColor: '#e0e0e0',
    onTertiaryColor: '#1a1c1d',
    neutralColor: '#F9F9FB',
    onNeutralColor: '#1a1c1d',
    backgroundColor: '#d9dadc',
    onBackgroundColor: '#1a1c1d',
    surfaceColor: '#eceef0',
    onSurfaceColor: '#1a1c1d',
    colorGreen: '#3BAE70',
    onGreenColor: '#FFFFFF',
    colorRed: '#ba1a1a',
    onRedColor: '#FFFFFF',
    colorOrange: '#F5A623',
    onOrangeColor: '#FFFFFF',
    inactiveColor: '#747575',
    onInactiveColor: '#ffffff',
    outlineColor: '#777777',
    shadowColor: '#00000033',
    skyGradientTop: '#89b4d8',
    skyGradientBottom: '#c8dff0',
    rainTint: '#7a9eb8',
    snowTint: '#ccdde8',
    sunTint: '#FFD166',
    nightTint: '#1e2a3a',
  ),
  ThemeType.dark: AppColors(
    primaryColor: '#FFFFFF',
    onPrimaryColor: '#0A1929',
    secondaryColor: '#8e8e93',
    onSecondaryColor: '#000000',
    tertiaryColor: '#f2f2f7',
    onTertiaryColor: '#000000',
    neutralColor: '#1c1c1e',
    onNeutralColor: '#e3e1e3',
    backgroundColor: '#121214',
    onBackgroundColor: '#e3e1e3',
    surfaceColor: '#1f1f21',
    onSurfaceColor: '#e3e1e3',
    colorGreen: '#4CC888',
    onGreenColor: '#FFFFFF',
    colorRed: '#ffb4ab',
    onRedColor: '#690005',
    colorOrange: '#FFAB40',
    onOrangeColor: '#FFFFFF',
    inactiveColor: '#8d8f94',
    onInactiveColor: '#000000',
    outlineColor: '#474747',
    shadowColor: '#000000',
    skyGradientTop: '#1c2b3a',
    skyGradientBottom: '#2a3d52',
    rainTint: '#1e2e3e',
    snowTint: '#2a3a4a',
    sunTint: '#FFD166',
    nightTint: '#0d1117',
  ),
};
