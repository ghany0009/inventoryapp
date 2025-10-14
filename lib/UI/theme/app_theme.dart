import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color primaryDarkColor = Color(0xFF4FC3F7);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color textDarkColor = Color(0xFFEAEAEA);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  //Para cambiar el style del login_page
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      );

  // TEMA CLARO

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLight,

    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: accentColor,
      onSurface: Colors.black,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: accentColor,
      unselectedItemColor: Colors.white70,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),

    inputDecorationTheme: _inputDecorationTheme.copyWith(
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.black54),
    ),
  );

  //TEMA OSCURO

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: backgroundDark,

    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: textDarkColor,
      elevation: 0,
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryDarkColor,
      secondary: accentColor,
      onSurface: textDarkColor,
      surface: darkSurface,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: Colors.white70,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
    ),

    inputDecorationTheme: _inputDecorationTheme.copyWith(
      fillColor: darkSurface,
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
  );
}
