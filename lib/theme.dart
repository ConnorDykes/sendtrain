import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A092D),
    primaryColor: const Color(0xFF8A2BE2),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8A2BE2),
      secondary: Color(0xFF007BFF),
      surface: Color(0xFF1F1E3D),
      onSurface: Colors.white,
      error: Color(0xFFDC3545),
    ),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF8A2BE2),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: const Color(0xFF8A2BE2).withOpacity(0.5),
      selectionHandleColor: const Color(0xFF8A2BE2),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF007BFF),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
