import 'package:flutter/material.dart';

class AppTheme {
  // --- Colores base ---
  static const Color primaryPurple = Color(0xFF892BE2);
  static const Color darkPurple = Color.fromARGB(255, 41, 0, 112);
  static const Color lightPurpleAccent = Color(0xFFDAB6FF);

  // --- TEMA CLARO ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryPurple,
      selectedItemColor: lightPurpleAccent,
      unselectedItemColor: Colors.white70,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryPurple,
      brightness: Brightness.light,
      primary: primaryPurple,
      secondary: lightPurpleAccent,
    ),
    // Configura otros widgets si es necesario
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
    ),
  );

  // --- TEMA OSCURO ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPurple,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPurple,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkPurple,
      selectedItemColor: lightPurpleAccent,
      unselectedItemColor: Colors.white70,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkPurple,
      brightness: Brightness.dark,
      primary: lightPurpleAccent,
      secondary: primaryPurple,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: lightPurpleAccent,
        foregroundColor: darkPurple,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPurpleAccent,
      foregroundColor: darkPurple,
    ),
  );
}
