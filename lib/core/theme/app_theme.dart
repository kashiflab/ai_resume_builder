import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/dashboard/presentation/widgets/notification_badge.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF26A69A);
  static const Color accentColor = Color(0xFFFFA726);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFB8C00);
  static const Color infoColor = Color(0xFF039BE5);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textPrimaryColor = Color(0xFF212121);

  // Light Theme Colors
  static const Color _lightPrimaryText = Color(0xFF212121);
  static const Color _lightSecondaryText = Color(0xFF757575);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightDivider = Color(0xFFBDBDBD);

  // Dark Theme Colors
  static const Color _darkPrimaryText = Color(0xFFFFFFFF);
  static const Color _darkSecondaryText = Color(0xFFB0BEC5);
  static const Color _darkBackground = Color(0xFF1F2937);
  static const Color _darkSurface = Color(0xFF374151);
  static const Color _darkDivider = Color(0xFF4B5563);

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
      error: errorColor,
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
        borderSide: BorderSide(color: _lightDivider.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightDivider.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: const TextStyle(color: _lightSecondaryText),
      hintStyle: const TextStyle(color: _lightSecondaryText),
      errorStyle: const TextStyle(color: errorColor),
      prefixIconColor: _lightSecondaryText,
      suffixIconColor: _lightSecondaryText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: _lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
    appBarTheme: _lightAppBarTheme,
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
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _darkPrimaryText,
      onBackground: _darkPrimaryText,
      onError: Colors.white,
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
        borderSide: BorderSide(color: _darkDivider.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkDivider.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: const TextStyle(color: _darkSecondaryText),
      hintStyle: const TextStyle(color: _darkSecondaryText),
      errorStyle: const TextStyle(color: errorColor),
      prefixIconColor: _darkSecondaryText,
      suffixIconColor: _darkSecondaryText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: _darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
      backgroundColor: _darkBackground,
      selectedItemColor: primaryColor,
      unselectedItemColor: _darkSecondaryText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    appBarTheme: _darkAppBarTheme,
  );

  static AppBarTheme get _lightAppBarTheme => AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: _lightPrimaryText,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: _lightPrimaryText),
        actionsIconTheme: IconThemeData(color: _lightPrimaryText),
      );

  static AppBarTheme get _darkAppBarTheme => AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: _darkPrimaryText,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: _darkPrimaryText),
        actionsIconTheme: IconThemeData(color: _darkPrimaryText),
      );
}
