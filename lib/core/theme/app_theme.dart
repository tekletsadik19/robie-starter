import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  // Color schemes
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2563EB), // Blue 600
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDBEAFE), // Blue 100
    onPrimaryContainer: Color(0xFF1E3A8A), // Blue 800
    secondary: Color(0xFF7C3AED), // Violet 600
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFEDE9FE), // Violet 100
    onSecondaryContainer: Color(0xFF5B21B6), // Violet 800
    tertiary: Color(0xFF059669), // Emerald 600
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD1FAE5), // Emerald 100
    onTertiaryContainer: Color(0xFF064E3B), // Emerald 800
    error: Color(0xFFDC2626), // Red 600
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2), // Red 100
    onErrorContainer: Color(0xFF991B1B), // Red 800
    outline: Color(0xFF6B7280), // Gray 500
    outlineVariant: Color(0xFFE5E7EB), // Gray 200
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF111827), // Gray 900
    surfaceContainerHighest: Color(0xFFF9FAFB), // Gray 50
    onSurfaceVariant: Color(0xFF374151), // Gray 700
    inverseSurface: Color(0xFF111827), // Gray 900
    onInverseSurface: Color(0xFFFFFFFF),
    inversePrimary: Color(0xFF93C5FD), // Blue 300
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF2563EB), // Blue 600
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF3B82F6), // Blue 500
    onPrimary: Color(0xFF1E3A8A), // Blue 800
    primaryContainer: Color(0xFF1D4ED8), // Blue 700
    onPrimaryContainer: Color(0xFFDBEAFE), // Blue 100
    secondary: Color(0xFF8B5CF6), // Violet 500
    onSecondary: Color(0xFF5B21B6), // Violet 800
    secondaryContainer: Color(0xFF7C3AED), // Violet 600
    onSecondaryContainer: Color(0xFFEDE9FE), // Violet 100
    tertiary: Color(0xFF10B981), // Emerald 500
    onTertiary: Color(0xFF064E3B), // Emerald 800
    tertiaryContainer: Color(0xFF059669), // Emerald 600
    onTertiaryContainer: Color(0xFFD1FAE5), // Emerald 100
    error: Color(0xFFEF4444), // Red 500
    onError: Color(0xFF991B1B), // Red 800
    errorContainer: Color(0xFFDC2626), // Red 600
    onErrorContainer: Color(0xFFFEE2E2), // Red 100
    outline: Color(0xFF9CA3AF), // Gray 400
    outlineVariant: Color(0xFF374151), // Gray 700
    surface: Color(0xFF111827), // Gray 900
    onSurface: Color(0xFFF9FAFB), // Gray 50
    surfaceContainerHighest: Color(0xFF1F2937), // Gray 800
    onSurfaceVariant: Color(0xFFD1D5DB), // Gray 300
    inverseSurface: Color(0xFFF9FAFB), // Gray 50
    onInverseSurface: Color(0xFF111827), // Gray 900
    inversePrimary: Color(0xFF2563EB), // Blue 600
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF3B82F6), // Blue 500
  );

  // Typography
  static const _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
  );

  // Light theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: _lightColorScheme,
        textTheme: _textTheme,
        brightness: Brightness.light,

        // AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: _lightColorScheme.surface,
          foregroundColor: _lightColorScheme.onSurface,
          elevation: 0,
          surfaceTintColor: _lightColorScheme.surfaceTint,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          centerTitle: true,
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: _lightColorScheme.onSurface,
          ),
        ),

        // Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Outlined button theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _lightColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _lightColorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _lightColorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _lightColorScheme.error, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Chip theme
        chipTheme: ChipThemeData(
          backgroundColor: _lightColorScheme.surfaceContainerHighest,
          selectedColor: _lightColorScheme.primaryContainer,
          disabledColor:
              _lightColorScheme.surfaceContainerHighest.withValues(alpha: 0.12),
          labelStyle: _textTheme.labelLarge,
          secondaryLabelStyle: _textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Dialog theme
        dialogTheme: DialogThemeData(
          backgroundColor: _lightColorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
        ),

        // Bottom sheet theme
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _lightColorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _lightColorScheme.primary,
          foregroundColor: _lightColorScheme.onPrimary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // List tile theme
        listTileTheme: ListTileThemeData(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Divider theme
        dividerTheme: DividerThemeData(
          color: _lightColorScheme.outlineVariant,
          thickness: 1,
          space: 1,
        ),
      );

  // Dark theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: _darkColorScheme,
        textTheme: _textTheme,
        brightness: Brightness.dark,

        // AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: _darkColorScheme.surface,
          foregroundColor: _darkColorScheme.onSurface,
          elevation: 0,
          surfaceTintColor: _darkColorScheme.surfaceTint,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          titleTextStyle: _textTheme.titleLarge?.copyWith(
            color: _darkColorScheme.onSurface,
          ),
        ),

        // Card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Outlined button theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _darkColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _darkColorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _darkColorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _darkColorScheme.error, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Chip theme
        chipTheme: ChipThemeData(
          backgroundColor: _darkColorScheme.surfaceContainerHighest,
          selectedColor: _darkColorScheme.primaryContainer,
          disabledColor:
              _darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.12),
          labelStyle: _textTheme.labelLarge,
          secondaryLabelStyle: _textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Dialog theme
        dialogTheme: DialogThemeData(
          backgroundColor: _darkColorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
        ),

        // Bottom sheet theme
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _darkColorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _darkColorScheme.primary,
          foregroundColor: _darkColorScheme.onPrimary,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // List tile theme
        listTileTheme: ListTileThemeData(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Divider theme
        dividerTheme: DividerThemeData(
          color: _darkColorScheme.outlineVariant,
          thickness: 1,
          space: 1,
        ),
      );
}
