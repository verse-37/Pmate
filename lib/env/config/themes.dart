import 'package:flutter/material.dart';

class PmateColorSets {
  static ColorScheme light = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1A5F7A),
    brightness: Brightness.light,
  );
  static ColorScheme dark = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1A5F7A),
    brightness: Brightness.dark,
  );
}

class PmateTextStyles {
  static TextStyle displayLarge(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Playfair_Display',
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      );

  static TextStyle displayMedium(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Playfair_Display',
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      );

  static TextStyle displaySmall(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Playfair_Display',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      );

  static TextStyle bodyLarge(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      );

  static TextStyle bodyMedium(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      );

  static TextStyle bodySmall(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface.withOpacity(0.8),
      );

  static TextStyle labelLarge(ColorScheme colorScheme) => TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorScheme.primary,
      );
}

class PmateThemes {
  static ThemeData light = ThemeData(
    colorScheme: PmateColorSets.light,
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: PmateTextStyles.displayLarge(PmateColorSets.light),
      displayMedium: PmateTextStyles.displayMedium(PmateColorSets.light),
      displaySmall: PmateTextStyles.displaySmall(PmateColorSets.light),
      bodyLarge: PmateTextStyles.bodyLarge(PmateColorSets.light),
      bodyMedium: PmateTextStyles.bodyMedium(PmateColorSets.light),
      bodySmall: PmateTextStyles.bodySmall(PmateColorSets.light),
      labelLarge: PmateTextStyles.labelLarge(PmateColorSets.light),
    ),
  );

  static ThemeData dark = ThemeData(
    colorScheme: PmateColorSets.dark,
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: PmateTextStyles.displayLarge(PmateColorSets.dark),
      displayMedium: PmateTextStyles.displayMedium(PmateColorSets.dark),
      displaySmall: PmateTextStyles.displaySmall(PmateColorSets.dark),
      bodyLarge: PmateTextStyles.bodyLarge(PmateColorSets.dark),
      bodyMedium: PmateTextStyles.bodyMedium(PmateColorSets.dark),
      bodySmall: PmateTextStyles.bodySmall(PmateColorSets.dark),
      labelLarge: PmateTextStyles.labelLarge(PmateColorSets.dark),
    ),
  );
}
