import 'package:supabase_flutter/supabase_flutter.dart';

/// Utility class for handling errors and providing user-friendly messages
class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is AuthException) {
      return _handleAuthError(error);
    } else if (error is PostgrestException) {
      return _handleDatabaseError(error);
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  static String _handleAuthError(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return 'Invalid email or password. Please try again.';
      case 'Email not confirmed':
        return 'Please verify your email address before signing in.';
      case 'User already registered':
        return 'An account with this email already exists.';
      case 'Password should be at least 6 characters':
        return 'Password must be at least 6 characters long.';
      case 'Invalid email':
        return 'Please enter a valid email address.';
      default:
        if (error.message.contains('weak password')) {
          return 'Please choose a stronger password.';
        } else if (error.message.contains('email format')) {
          return 'Please enter a valid email address.';
        }
        return 'Authentication failed. Please try again.';
    }
  }

  static String _handleDatabaseError(PostgrestException error) {
    // Instead of showing raw database errors, return user-friendly messages
    if (error.message.contains('duplicate key')) {
      return 'This information already exists.';
    } else if (error.message.contains('foreign key')) {
      return 'Unable to process this request.';
    } else if (error.message.contains('not-found')) {
      return 'The requested information was not found.';
    } else if (error.message.contains('permission denied')) {
      return 'You don\'t have permission to perform this action.';
    }
    return 'Unable to process your request. Please try again.';
  }

  // Social sign-in specific errors
  static String handleSocialSignInError(String provider, dynamic error) {
    if (error is AuthException) {
      switch (provider.toLowerCase()) {
        case 'google':
          return 'Unable to sign in with Google. Please try again.';
        case 'apple':
          return 'Unable to sign in with Apple. Please try again.';
        case 'linkedin':
          return 'Unable to sign in with LinkedIn. Please try again.';
        default:
          return 'Social sign-in failed. Please try again.';
      }
    }
    return getErrorMessage(error);
  }

  // Profile update errors
  static String handleProfileUpdateError(dynamic error) {
    if (error is PostgrestException) {
      if (error.message.contains('storage')) {
        return 'Unable to upload profile picture. Please try again.';
      } else if (error.message.contains('update')) {
        return 'Unable to update profile. Please try again.';
      }
    }
    return getErrorMessage(error);
  }

  // Network-related errors
  static String handleNetworkError() {
    return 'Please check your internet connection and try again.';
  }

  // Session-related errors
  static String handleSessionError() {
    return 'Your session has expired. Please sign in again.';
  }

  // Form validation errors
  static String handleValidationError(String field) {
    switch (field.toLowerCase()) {
      case 'email':
        return 'Please enter a valid email address.';
      case 'password':
        return 'Password must be at least 6 characters long.';
      case 'name':
        return 'Please enter your full name.';
      case 'career_goals':
        return 'Please enter valid career goals.';
      case 'job_preferences':
        return 'Please enter valid job preferences.';
      default:
        return 'Please check your input and try again.';
    }
  }
}
