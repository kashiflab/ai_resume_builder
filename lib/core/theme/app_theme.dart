import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color secondaryColor = Color(0xFF3B82F6);
  static const Color accentColor = Color(0xFF60A5FA);
  static const Color errorColor = Color(0xFFDC2626);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);
  static const Color textSecondaryColor = Color(0xFF6B7280);
  static const Color textPrimaryColor = Color(0xFF1F2937);

  // Light Theme Colors
  static const Color _lightPrimaryText = Color(0xFF1F2937);
  static const Color _lightSecondaryText = Color(0xFF6B7280);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFF3F4F6);
  static const Color _lightError = Color(0xFFDC2626);
  static const Color _lightBorder = Color(0xFFE5E7EB);
  static const Color _lightDivider = Color(0xFFE5E7EB);

  // Dark Theme Colors
  static const Color _darkPrimaryText = Color(0xFFF9FAFB);
  static const Color _darkSecondaryText = Color(0xFFD1D5DB);
  static const Color _darkBackground = Color(0xFF111827);
  static const Color _darkSurface = Color(0xFF1F2937);
  static const Color _darkError = Color(0xFFFCA5A5);
  static const Color _darkBorder = Color(0xFF374151);
  static const Color _darkDivider = Color(0xFF374151);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: _lightSurface,
      background: _lightBackground,
      error: _lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _lightPrimaryText,
      onBackground: _lightPrimaryText,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: const TextStyle(color: _lightPrimaryText),
      displayMedium: const TextStyle(color: _lightPrimaryText),
      displaySmall: const TextStyle(color: _lightPrimaryText),
      headlineLarge: const TextStyle(color: _lightPrimaryText),
      headlineMedium: const TextStyle(color: _lightPrimaryText),
      headlineSmall: const TextStyle(color: _lightPrimaryText),
      titleLarge: const TextStyle(color: _lightPrimaryText),
      titleMedium: const TextStyle(color: _lightPrimaryText),
      titleSmall: const TextStyle(color: _lightPrimaryText),
      bodyLarge: const TextStyle(color: _lightPrimaryText),
      bodyMedium: const TextStyle(color: _lightPrimaryText),
      bodySmall: const TextStyle(color: _lightSecondaryText),
      labelLarge: const TextStyle(color: _lightPrimaryText),
      labelMedium: const TextStyle(color: _lightSecondaryText),
      labelSmall: const TextStyle(color: _lightSecondaryText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightError, width: 2),
      ),
      labelStyle: const TextStyle(color: _lightSecondaryText),
      hintStyle: const TextStyle(color: _lightSecondaryText),
      errorStyle: const TextStyle(color: _lightError),
      prefixIconColor: _lightSecondaryText,
      suffixIconColor: _lightSecondaryText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: _lightBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _lightBorder),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _lightDivider,
      thickness: 1,
    ),
    iconTheme: const IconThemeData(
      color: _lightPrimaryText,
      size: 24,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _lightSecondaryText;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor.withOpacity(0.5);
        }
        return _lightSecondaryText.withOpacity(0.5);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _lightSecondaryText;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _lightSecondaryText;
      }),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _lightBackground,
      selectedItemColor: primaryColor,
      unselectedItemColor: _lightSecondaryText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightBackground,
      foregroundColor: _lightPrimaryText,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _lightPrimaryText),
      actionsIconTheme: IconThemeData(color: _lightPrimaryText),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: _darkSurface,
      background: _darkBackground,
      error: _darkError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _darkPrimaryText,
      onBackground: _darkPrimaryText,
      onError: _darkBackground,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: const TextStyle(color: _darkPrimaryText),
      displayMedium: const TextStyle(color: _darkPrimaryText),
      displaySmall: const TextStyle(color: _darkPrimaryText),
      headlineLarge: const TextStyle(color: _darkPrimaryText),
      headlineMedium: const TextStyle(color: _darkPrimaryText),
      headlineSmall: const TextStyle(color: _darkPrimaryText),
      titleLarge: const TextStyle(color: _darkPrimaryText),
      titleMedium: const TextStyle(color: _darkPrimaryText),
      titleSmall: const TextStyle(color: _darkPrimaryText),
      bodyLarge: const TextStyle(color: _darkPrimaryText),
      bodyMedium: const TextStyle(color: _darkPrimaryText),
      bodySmall: const TextStyle(color: _darkSecondaryText),
      labelLarge: const TextStyle(color: _darkPrimaryText),
      labelMedium: const TextStyle(color: _darkSecondaryText),
      labelSmall: const TextStyle(color: _darkSecondaryText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkError, width: 2),
      ),
      labelStyle: const TextStyle(color: _darkSecondaryText),
      hintStyle: const TextStyle(color: _darkSecondaryText),
      errorStyle: const TextStyle(color: _darkError),
      prefixIconColor: _darkSecondaryText,
      suffixIconColor: _darkSecondaryText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: _darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _darkBorder),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _darkDivider,
      thickness: 1,
    ),
    iconTheme: const IconThemeData(
      color: _darkPrimaryText,
      size: 24,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _darkSecondaryText;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor.withOpacity(0.5);
        }
        return _darkSecondaryText.withOpacity(0.5);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _darkSecondaryText;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return _darkSecondaryText;
      }),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _darkSurface,
      selectedItemColor: primaryColor,
      unselectedItemColor: _darkSecondaryText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkBackground,
      foregroundColor: _darkPrimaryText,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _darkPrimaryText),
      actionsIconTheme: IconThemeData(color: _darkPrimaryText),
    ),
  );
}
