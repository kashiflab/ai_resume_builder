import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../widgets/dashboard_bottom_nav.dart';
import '../widgets/dashboard_fab.dart';
import '../widgets/notification_badge.dart';
import 'home/home_screen.dart';
import 'quick_actions/quick_actions_screen.dart';
import 'templates/templates_screen.dart';
import 'saved/saved_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TemplatesScreen(),
    const SizedBox(), // Placeholder for FAB
    const SavedScreen(),
    // const ProfileScreen(),
    const SettingsScreen(),
  ];

  void _handleFabPressed() {
    context.push(AppRoute.quickActions.path);
  }

  String _getTitle(int index) {
    if (index == 0) {
      return 'Home';
    } else if (index == 1) {
      return 'Templates';
    } else if (index == 2) {
      return 'Quick Actions';
    } else if (index == 3) {
      return 'Saved';
    } else if (index == 4) {
      return 'Settings';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated,
      listener: (context, state) {
        if (!state.isAuthenticated) {
          context.go(AppRoute.signIn.path);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // drawer: DashboardDrawer(
          //   name: context.read<AuthBloc>().state.user?.fullName ?? 'Guest',
          //   email: context.read<AuthBloc>().state.user?.email,
          // ),
          appBar: AppBar(
            centerTitle: false,
            title: _currentIndex == 0
                ? Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        radius: 16,
                        child: Text(
                          context
                                  .read<AuthBloc>()
                                  .state
                                  .user
                                  ?.fullName?[0]
                                  .toUpperCase() ??
                              'AI',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.read<AuthBloc>().state.user?.fullName ??
                            'Guest',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Text(
                    _getTitle(_currentIndex),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
            actions: [
              const NotificationBadge(),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          floatingActionButton: DashboardFab(
            onPressed: _handleFabPressed,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: DashboardBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ),
      ),
    );
  }
}
