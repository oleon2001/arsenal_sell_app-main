import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'palette.dart';
import 'design_system.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          primary: AppPalette.primary,
          secondary: AppPalette.secondary,
          surface: AppPalette.surface,
          background: AppPalette.background,
          error: AppPalette.error,
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: AppTypography.headline4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.primary,
          unselectedItemColor: AppPalette.textSecondary,
          selectedLabelStyle: AppTypography.labelMedium,
          unselectedLabelStyle: AppTypography.labelSmall,
          elevation: 8,
          backgroundColor: Colors.white,
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.lg),
          ),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.primary,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: AppShapes.buttonShape,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.buttonPadding,
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppPalette.primary,
            side: const BorderSide(color: AppPalette.primary),
            shape: AppShapes.buttonShape,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.buttonPadding,
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppPalette.primary,
            shape: AppShapes.buttonShape,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.buttonPadding,
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        // Card Theme
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: AppShapes.cardShape,
          margin: EdgeInsets.only(bottom: AppSpacing.listItemSpacing),
          color: AppPalette.surface,
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.error),
          ),
          filled: true,
          fillColor: AppPalette.surface,
          contentPadding: const EdgeInsets.all(AppSpacing.inputPadding),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppPalette.textSecondary,
          ),
        ),

        // Dialog Theme
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.lg),
          ),
          elevation: 8,
          backgroundColor: AppPalette.surface,
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppPalette.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppShapes.lg),
            ),
          ),
          elevation: 8,
        ),

        // SnackBar Theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppPalette.primary,
          contentTextStyle: AppTypography.bodyMedium.copyWith(
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        // Tab Bar Theme
        tabBarTheme: const TabBarThemeData(
          labelColor: AppPalette.primary,
          unselectedLabelColor: AppPalette.textSecondary,
          indicatorColor: AppPalette.primary,
          labelStyle: AppTypography.labelLarge,
          unselectedLabelStyle: AppTypography.labelMedium,
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: AppPalette.divider,
          thickness: 1,
          space: AppSpacing.md,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: AppPalette.textSecondary,
          size: 24,
        ),

        // Text Theme
        textTheme: const TextTheme(
          displayLarge: AppTypography.headline1,
          displayMedium: AppTypography.headline2,
          displaySmall: AppTypography.headline3,
          headlineLarge: AppTypography.headline4,
          headlineMedium: AppTypography.bodyLarge,
          headlineSmall: AppTypography.bodyMedium,
          titleLarge: AppTypography.labelLarge,
          titleMedium: AppTypography.labelMedium,
          titleSmall: AppTypography.labelSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),

        // Color Scheme
        scaffoldBackgroundColor: AppPalette.background,
        primaryColor: AppPalette.primary,
        primarySwatch: _createMaterialColor(AppPalette.primary),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          brightness: Brightness.dark,
          primary: AppPalette.primary,
          secondary: AppPalette.secondary,
          surface: AppPalette.surfaceDark,
          background: AppPalette.surfaceDark,
          error: AppPalette.error,
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppPalette.surfaceDark,
          foregroundColor: AppPalette.textOnSurfaceDark,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: AppTypography.headline4.copyWith(
            color: AppPalette.textOnSurfaceDark,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: AppPalette.textOnSurfaceDark),
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.primary,
          unselectedItemColor: AppPalette.textSecondary,
          selectedLabelStyle: AppTypography.labelMedium,
          unselectedLabelStyle: AppTypography.labelSmall,
          elevation: 8,
          backgroundColor: AppPalette.surfaceDark,
        ),

        // Card Theme
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: AppShapes.cardShape,
          margin: EdgeInsets.only(bottom: AppSpacing.listItemSpacing),
          color: AppPalette.surfaceVariantDark,
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.dividerDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.dividerDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.sm),
            borderSide: const BorderSide(color: AppPalette.error),
          ),
          filled: true,
          fillColor: AppPalette.surfaceVariantDark,
          contentPadding: const EdgeInsets.all(AppSpacing.inputPadding),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppPalette.textSecondary,
          ),
        ),

        // Dialog Theme
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.lg),
          ),
          elevation: 8,
          backgroundColor: AppPalette.surfaceDark,
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppPalette.surfaceDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppShapes.lg),
            ),
          ),
          elevation: 8,
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: AppPalette.dividerDark,
          thickness: 1,
          space: AppSpacing.md,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: AppPalette.textSecondary,
          size: 24,
        ),

        // Text Theme
        textTheme: TextTheme(
          displayLarge: AppTypography.headline1.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          displayMedium: AppTypography.headline2.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          displaySmall: AppTypography.headline3.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          headlineLarge: AppTypography.headline4.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          headlineMedium: AppTypography.bodyLarge.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          headlineSmall: AppTypography.bodyMedium.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          titleLarge: AppTypography.labelLarge.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          titleMedium: AppTypography.labelMedium.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          titleSmall: AppTypography.labelSmall.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          bodyLarge: AppTypography.bodyLarge.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          bodyMedium: AppTypography.bodyMedium.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          bodySmall: AppTypography.bodySmall.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          labelLarge: AppTypography.labelLarge.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          labelMedium: AppTypography.labelMedium.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
          labelSmall: AppTypography.labelSmall.copyWith(
            color: AppPalette.textOnSurfaceDark,
          ),
        ),

        // Color Scheme
        scaffoldBackgroundColor: AppPalette.surfaceDark,
        primaryColor: AppPalette.primary,
        primarySwatch: _createMaterialColor(AppPalette.primary),
      );

  // Helper method to create MaterialColor from a single color
  static MaterialColor _createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
