import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/settings/presentation/pages/profile_settings_screen.dart';
import '../../features/settings/presentation/pages/change_password_screen.dart';
import '../../features/settings/presentation/pages/subscription_screen.dart';
import '../../features/settings/presentation/pages/template_settings_screen.dart';
import '../../features/settings/presentation/pages/font_settings_screen.dart';
import '../../features/settings/presentation/pages/export_settings_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash Route
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Auth Routes
    GoRoute(
      path: '/auth',
      builder: (context, state) => const SignInScreen(),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),

    // Main App Routes (Protected)
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),

    // Settings Routes (Protected)
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        // Profile Settings Routes
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileSettingsScreen(),
        ),
        GoRoute(
          path: 'change-password',
          builder: (context, state) => const ChangePasswordScreen(),
        ),

        // Subscription Routes
        GoRoute(
          path: 'subscription',
          builder: (context, state) => const SubscriptionScreen(),
        ),

        // Resume Settings Routes
        GoRoute(
          path: 'template',
          builder: (context, state) => const TemplateSettingsScreen(),
        ),
        GoRoute(
          path: 'fonts',
          builder: (context, state) => const FontSettingsScreen(),
        ),

        // Export Settings Routes
        GoRoute(
          path: 'export',
          builder: (context, state) => const ExportSettingsScreen(),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    try {
      // Get current session from Supabase
      final session = Supabase.instance.client.auth.currentSession;
      final isAuthenticated = session != null && !session.isExpired;

      // Check if the user is on auth pages or splash screen
      final isOnAuthPage = state.matchedLocation.startsWith('/auth');
      final isOnSplashPage = state.matchedLocation == '/';

      // If not authenticated and not on auth pages or splash, redirect to auth
      if (!isAuthenticated && !isOnAuthPage && !isOnSplashPage) {
        return '/auth';
      }

      // If authenticated and on auth pages, redirect to dashboard
      if (isAuthenticated && isOnAuthPage) {
        return '/dashboard';
      }

      // Allow the navigation to proceed
      return null;
    } catch (e) {
      // If there's an error checking auth state, redirect to auth
      if (!state.matchedLocation.startsWith('/auth')) {
        return '/auth';
      }
      return null;
    }
  },
);
