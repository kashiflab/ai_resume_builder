import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardFab extends StatelessWidget {
  final VoidCallback onPressed;

  const DashboardFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: onPressed,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Iconsax.add,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
