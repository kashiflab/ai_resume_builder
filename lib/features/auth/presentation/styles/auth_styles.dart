import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Authentication screen styles
class AuthStyles {
  static const double horizontalPadding = 24.0;
  static const double verticalPadding = 16.0;
  static const double spacing = 16.0;
  static const double buttonHeight = 50.0;
  static const double socialButtonHeight = 48.0;
  static const double borderRadius = 12.0;

  static const dividerStyle = TextStyle(
    color: AppTheme.textSecondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final socialButtonDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(borderRadius),
  );

  static const titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppTheme.textPrimaryColor,
  );

  static const subtitleStyle = TextStyle(
    fontSize: 16,
    color: AppTheme.textSecondaryColor,
  );

  static InputDecoration inputDecoration({
    required String label,
    required String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppTheme.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppTheme.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: AppTheme.errorColor),
      ),
    );
  }
}
