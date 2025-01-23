import 'package:ai_resume_builder/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          const _SectionHeader(title: 'Profile'),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Profile Settings',
            subtitle: 'Update your personal information',
            onTap: () => context.push(AppRoute.settingsProfile.path),
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => context.push(AppRoute.settingsChangePassword.path),
          ),

          const SizedBox(height: 24),

          // Appearance Section
          // const _SectionHeader(title: 'Appearance'),
          // _SettingsTile(
          //   icon: Icons.dark_mode_outlined,
          //   title: 'Dark Mode',
          //   subtitle: 'Toggle dark/light theme',
          //   trailing: Switch(
          //     value: Theme.of(context).brightness == Brightness.dark,
          //     onChanged: (value) {
          //       // TODO: Implement theme switching
          //     },
          //   ),
          // ),

          // const SizedBox(height: 24),

          // Subscription Section
          const _SectionHeader(title: 'Subscription'),
          _SettingsTile(
            icon: Icons.workspace_premium_outlined,
            title: 'Premium Features',
            subtitle: 'Upgrade to access premium features',
            onTap: () => context.push(AppRoute.settingsSubscription.path),
          ),

          const SizedBox(height: 24),

          // Resume Settings Section
          const _SectionHeader(title: 'Resume Settings'),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: 'Default Resume Template',
            subtitle: 'Set your preferred template',
            onTap: () => context.push(AppRoute.settingsTemplate.path),
          ),
          _SettingsTile(
            icon: Icons.format_size_outlined,
            title: 'Font Settings',
            subtitle: 'Customize resume fonts',
            onTap: () => context.push(AppRoute.settingsFonts.path),
          ),

          const SizedBox(height: 24),

          // Export Settings Section
          const _SectionHeader(title: 'Export Settings'),
          _SettingsTile(
            icon: Icons.picture_as_pdf_outlined,
            title: 'PDF Quality',
            subtitle: 'Configure export quality',
            onTap: () => context.push(AppRoute.settingsExport.path),
          ),

          const SizedBox(height: 24),

          // Account Section
          const _SectionHeader(title: 'Account'),
          _SettingsTile(
            icon: Icons.backup_outlined,
            title: 'Backup & Sync',
            subtitle: 'Manage your data',
            onTap: () => context.push(AppRoute.settingsBackup.path),
          ),
          _SettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'Change app language',
            onTap: () => context.push(AppRoute.settingsLanguage.path),
          ),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            onTap: () => context.push(AppRoute.settingsNotifications.path),
          ),

          const SizedBox(height: 24),

          // About Section
          const _SectionHeader(title: 'About'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About App',
            subtitle: 'Version, terms, and privacy policy',
            onTap: () => context.push(AppRoute.about.path),
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () => context.push(AppRoute.help.path),
          ),

          const SizedBox(height: 24),

          // Danger Zone
          const _SectionHeader(title: 'Danger Zone', color: Colors.red),
          _SettingsTile(
            icon: Icons.logout,
            title: 'Sign Out',
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: () {
              // TODO: Implement sign out logic
              context.go(AppRoute.signIn.path);
            },
          ),
          _SettingsTile(
            icon: Icons.delete_forever_outlined,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account and data',
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: () {
              // TODO: Show delete account confirmation dialog
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;

  const _SectionHeader({
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
