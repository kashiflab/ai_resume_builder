import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          context,
          title: 'Account',
          items: [
            _buildSettingItem(
              context,
              title: 'Profile',
              icon: Iconsax.user,
              onTap: () => context.push(AppRoute.settingsProfile.path),
            ),
            _buildSettingItem(
              context,
              title: 'Change Password',
              icon: Iconsax.lock,
              onTap: () => context.push(AppRoute.settingsChangePassword.path),
            ),
            _buildSettingItem(
              context,
              title: 'Subscription',
              icon: Iconsax.crown,
              onTap: () => context.push(AppRoute.settingsSubscription.path),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          title: 'Preferences',
          items: [
            _buildSettingItem(
              context,
              title: 'Template Settings',
              icon: Iconsax.document_text,
              onTap: () => context.push(AppRoute.settingsTemplate.path),
            ),
            _buildSettingItem(
              context,
              title: 'Font Settings',
              icon: Iconsax.text,
              onTap: () => context.push(AppRoute.settingsFonts.path),
            ),
            _buildSettingItem(
              context,
              title: 'Export Settings',
              icon: Iconsax.export,
              onTap: () => context.push(AppRoute.settingsExport.path),
            ),
            _buildSettingItem(
              context,
              title: 'Notifications',
              icon: Iconsax.notification,
              onTap: () => context.push(AppRoute.settingsNotifications.path),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          title: 'Support',
          items: [
            _buildSettingItem(
              context,
              title: 'Help & Support',
              icon: Iconsax.message_question,
              onTap: () => context.push(AppRoute.help.path),
            ),
            _buildSettingItem(
              context,
              title: 'About',
              icon: Iconsax.info_circle,
              onTap: () => context.push(AppRoute.about.path),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          title: 'Account',
          items: [
            _buildSettingItem(
              context,
              title: 'Sign Out',
              icon: Iconsax.logout,
              onTap: () {
                context.read<AuthBloc>().add(const SignOutEvent());
              },
              textColor: Colors.red,
              iconColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? AppTheme.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.grey.shade800,
                ),
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
