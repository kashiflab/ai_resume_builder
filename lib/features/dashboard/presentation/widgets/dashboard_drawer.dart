import 'package:ai_resume_builder/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class DashboardDrawer extends StatelessWidget {
  final String name;
  final String? email;

  const DashboardDrawer({
    super.key,
    required this.name,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
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
                    email!,
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
              // context.push(AppRoute.settings.path);
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.helpCircle),
            title: const Text('Help & Support'),
            onTap: () {
              context.push(AppRoute.help.path);
            },
          ),
          ListTile(
            leading: const Icon(FeatherIcons.info),
            title: const Text('About'),
            onTap: () {
              context.push(AppRoute.about.path);
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
}
