import 'package:ai_resume_builder/features/resume/domain/models/resume_model.dart';
import 'package:ai_resume_builder/features/resume/presentation/widgets/ai_analysis_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/app_routes.dart';
import '../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/dashboard/presentation/pages/notifications/notifications_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/settings/presentation/pages/profile_settings_screen.dart';
import '../../features/settings/presentation/pages/change_password_screen.dart';
import '../../features/settings/presentation/pages/subscription_screen.dart';
import '../../features/settings/presentation/pages/template_settings_screen.dart';
import '../../features/settings/presentation/pages/font_settings_screen.dart';
import '../../features/settings/presentation/pages/export_settings_screen.dart';
import '../../features/resume/presentation/pages/resume_creation_screen.dart';
import '../../features/dashboard/presentation/pages/quick_actions/quick_actions_screen.dart';
import '../../features/resume/presentation/pages/import/import_resume_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final session = Supabase.instance.client.auth.currentSession;
        final isAuthenticated = session != null && !session.isExpired;
        return isAuthenticated ? AppRoute.dashboard.path : AppRoute.signIn.path;
      },
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
      builder: (context, state) => const NotificationsScreen(),
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
  redirect: (context, state) {
    try {
      // Get current session from Supabase
      final session = Supabase.instance.client.auth.currentSession;
      final isAuthenticated = session != null && !session.isExpired;

      // Check if the user is on auth pages
      final isAuthPath = [
        AppRoute.signIn.path,
        AppRoute.signUp.path,
        AppRoute.forgotPassword.path,
      ].contains(state.matchedLocation);

      // If not authenticated and not on auth pages, redirect to auth
      if (!isAuthenticated && !isAuthPath) {
        return AppRoute.signIn.path;
      }

      // If authenticated and on auth pages, redirect to dashboard
      if (isAuthenticated && isAuthPath) {
        return AppRoute.dashboard.path;
      }

      // Allow the navigation to proceed
      return null;
    } catch (e) {
      // If there's an error checking auth state, redirect to auth
      if (![
        AppRoute.signIn.path,
        AppRoute.signUp.path,
        AppRoute.forgotPassword.path,
      ].contains(state.matchedLocation)) {
        return AppRoute.signIn.path;
      }
      return null;
    }
  },
);
