import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppPalette.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppPalette.primary,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppPalette.secondary,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: AppPalette.surface,
      ),
    );

  static ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppPalette.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
}
