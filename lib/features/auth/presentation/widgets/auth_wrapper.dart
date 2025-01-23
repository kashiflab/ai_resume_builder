import 'package:ai_resume_builder/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/auth_bloc.dart';
import '../pages/sign_in_screen.dart';

/// Widget that handles authentication state and navigation
class AuthWrapper extends StatelessWidget {
  final Widget? child;
  final bool showInitialLoading;

  const AuthWrapper({
    super.key,
    this.child,
    this.showInitialLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null &&
          !current.isInitialState &&
          current.errorMessage != previous.errorMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppTheme.errorColor,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading && state.isInitialState && showInitialLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return state.isAuthenticated
            ? child ?? const DashboardScreen()
            : const SignInScreen();
      },
    );
  }
}
