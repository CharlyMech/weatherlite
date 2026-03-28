import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherlite/core/theme/app_colors.dart';

/// Extension on [AppColors] that converts the custom color definition into
/// Flutter's [ThemeData], ready to be passed to [MaterialApp.theme].
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: appColorSchemes[ThemeType.light]!.toThemeData(),
///   darkTheme: appColorSchemes[ThemeType.dark]!.toThemeData(),
/// );
/// ```
extension AppColorsToThemeData on AppColors {
  ThemeData toThemeData() {
    final Color text = parse(onBackgroundColor);
    final bool isLight = this == appColorSchemes[ThemeType.light];

    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      // ── Text theme ──────────────────────────────────────────────────────
      textTheme: TextTheme(
        // Display – used for the large temperature readout
        displayLarge: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 72,
          fontWeight: FontWeight.w200,
          letterSpacing: -2,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 57,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 45,
          fontWeight: FontWeight.w300,
        ),
        // Headlines – section titles, city name
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        // Titles – card headings
        titleLarge: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.spaceGrotesk(
          color: text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        // Body – descriptions, detail rows
        bodyLarge: GoogleFonts.dmSans(
          color: text,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.dmSans(
          color: text,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.dmSans(
          color: text,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        // Labels – chips, badges, buttons
        labelLarge: GoogleFonts.dmSans(
          color: text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: GoogleFonts.dmSans(
          color: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.dmSans(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      // ── Color scheme ────────────────────────────────────────────────────
      colorScheme: ColorScheme(
        brightness: isLight ? Brightness.light : Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        tertiary: tertiary,
        onTertiary: onTertiary,
        surface: surface,
        onSurface: onSurface,
        error: red,
        onError: onRed,
      ),
      // ── Component themes ─────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: shadow,
        backgroundColor: background,
        surfaceTintColor: background,
        foregroundColor: parse(onBackgroundColor),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        iconSize: 28,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(primary),
          foregroundColor: WidgetStateProperty.all(onPrimary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: outline, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(color: outline, thickness: 1),
      iconTheme: IconThemeData(color: parse(onBackgroundColor)),
    );
  }
}
