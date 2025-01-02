import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:feather_icons/feather_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/pages/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const _TemplatesTab(),
    const SizedBox(), // Placeholder for FAB
    const _SavedTab(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;

    return Scaffold(
      drawer: _buildDrawer(user?.fullName ?? 'Guest', user?.email),
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
      floatingActionButton: Container(
        height: 64,
        width: 64,
        margin: const EdgeInsets.only(top: 32),
        child: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(
            Iconsax.add,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () {
            // TODO: Handle create new resume
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer(String name, String? email) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.primaryColor),
            accountName: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: email != null
                ? Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                : null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FeatherIcons.settings),
            title: const Text('Settings'),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.helpCircle),
            title: const Text('Help & Support'),
            onTap: () {
              // TODO: Navigate to help
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.info),
            title: const Text('About'),
            onTap: () {
              // TODO: Navigate to about
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(FeatherIcons.logOut),
            title: const Text('Sign Out'),
            onTap: () {
              context.read<AuthBloc>().add(const SignOutEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomAppBar(
        height: 60,
        notchMargin: 8,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Iconsax.home, 'Home'),
            _buildNavItem(1, Iconsax.document, 'Templates'),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(3, Iconsax.save_2, 'Saved'),
            _buildNavItem(4, Iconsax.profile_circle, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryColor : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Tab'),
    );
  }
}

class _TemplatesTab extends StatelessWidget {
  const _TemplatesTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Templates Tab'),
    );
  }
}

class _SavedTab extends StatelessWidget {
  const _SavedTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Saved Tab'),
    );
  }
}
