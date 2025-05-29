import 'package:ai_resume_builder/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presenter/auth/sign_in_screen.dart';
import '../../presenter/auth/sign_up_screen.dart';
import '../../presenter/auth/forgot_password_screen.dart';
import '../../presenter/dashboard/dashboard_screen.dart';
import '../../presenter/dashboard/notifications/notifications_screen.dart';

import '../../presenter/settings/profile_settings_screen.dart';
import '../../presenter/settings/change_password_screen.dart';
import '../../presenter/settings/subscription_screen.dart';
import '../../presenter/settings/template_settings_screen.dart';
import '../../presenter/settings/font_settings_screen.dart';
import '../../presenter/settings/export_settings_screen.dart';
import '../../presenter/resume/resume_creation_screen.dart';
import '../../presenter/dashboard/quick_actions/quick_actions_screen.dart';
import '../../presenter/resume/import/import_resume_screen.dart';
import '../../presenter/splash/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class GoRouterDelegate {
  final goRouter = GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoute.signIn.path,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main App Routes (Protected)
      GoRoute(
        path: AppRoute.dashboard.path,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoute.createResume.path,
        builder: (context, state) => ResumeCreationScreen(
          templateId: state.uri.queryParameters['templateId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoute.importResume.path,
        builder: (context, state) => const ImportResumeScreen(),
      ),
      GoRoute(
        path: AppRoute.quickActions.path,
        builder: (context, state) => const QuickActionsScreen(),
      ),
      GoRoute(
        path: AppRoute.notifications.path,
        builder: (context, state) => NotificationsScreen(),
      ),

      // Settings Routes (Protected)
      // GoRoute(
      //   path: AppRoute.settings.path,
      //   builder: (context, state) => const SettingsScreen(),
      // ),
      GoRoute(
        path: AppRoute.settingsProfile.path,
        builder: (context, state) => const ProfileSettingsScreen(),
      ),
      GoRoute(
        path: AppRoute.settingsChangePassword.path,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoute.settingsSubscription.path,
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: AppRoute.settingsTemplate.path,
        builder: (context, state) => const TemplateSettingsScreen(),
      ),
      GoRoute(
        path: AppRoute.settingsFonts.path,
        builder: (context, state) => const FontSettingsScreen(),
      ),
      GoRoute(
        path: AppRoute.settingsExport.path,
        builder: (context, state) => const ExportSettingsScreen(),
      ),
    ],
    // redirect: (context, state) {
    //   try {
    //     // Get current session from Supabase
    //     final session = Supabase.instance.client.auth.currentSession;
    //     final isAuthenticated = session != null && !session.isExpired;

    //     // Check if the user is on auth pages
    //     final isAuthPath = [
    //       AppRoute.signIn.path,
    //       AppRoute.signUp.path,
    //       AppRoute.forgotPassword.path,
    //     ].contains(state.matchedLocation);

    //     // If not authenticated and not on auth pages, redirect to auth
    //     if (!isAuthenticated && !isAuthPath) {
    //       return AppRoute.signIn.path;
    //     }

    //     // If authenticated and on auth pages, redirect to dashboard
    //     if (isAuthenticated && isAuthPath) {
    //       return AppRoute.dashboard.path;
    //     }

    //     // Allow the navigation to proceed
    //     return null;
    //   } catch (e) {
    //     // If there's an error checking auth state, redirect to auth
    //     if (![
    //       AppRoute.signIn.path,
    //       AppRoute.signUp.path,
    //       AppRoute.forgotPassword.path,
    //     ].contains(state.matchedLocation)) {
    //       return AppRoute.signIn.path;
    //     }
    //     return null;
    //   }
    // },
  );
}
