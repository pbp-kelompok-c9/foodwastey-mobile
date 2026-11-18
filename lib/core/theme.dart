import 'package:flutter/material.dart';

/// Warna mengikuti token CSS situs web FoodWastey (docs/color-palette.md).
class AppColors {
  static const paper = Color(0xFFFDECD8);
  static const ink = Color(0xFF6D3510);
  static const accentDark = Color(0xFF597828);
  static const accentDarkDeep = Color(0xFF435A1E);
  static const accentDarkActive = Color(0xFF283612);
  static const accentLight = Color(0xFFEEF2EA);
  static const accentLightActive = Color(0xFFCCD5BC);
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.accentDark,
    primary: AppColors.accentDark,
    onPrimary: AppColors.accentLight,
    secondary: AppColors.ink,
    surface: AppColors.paper,
    onSurface: AppColors.ink,
  );
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.accentLightActive),
  );
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.paper,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.accentDark,
      foregroundColor: AppColors.accentLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppColors.accentDark, width: 2)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.accentLightActive),
      ),
    ),
  );
}
