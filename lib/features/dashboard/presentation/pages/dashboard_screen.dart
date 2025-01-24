import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/pages/profile_screen.dart';
import '../widgets/dashboard_drawer.dart';
import '../widgets/dashboard_bottom_nav.dart';
import '../widgets/dashboard_fab.dart';
import 'home/home_screen.dart';
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
    const ProfileScreen(),
  ];

  void _handleFabPressed() {
    // TODO: Handle create new resume
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
          drawer: DashboardDrawer(
            name: context.read<AuthBloc>().state.user?.fullName ?? 'Guest',
            email: context.read<AuthBloc>().state.user?.email,
          ),
          appBar: AppBar(
            title: const Text('AI Resume Builder'),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.notification),
                onPressed: () {
                  // TODO: Handle notifications
                },
              ),
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
