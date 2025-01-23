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
      height: 64,
      width: 64,
      margin: const EdgeInsets.only(top: 32),
      child: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: onPressed,
        child: const Icon(
          Iconsax.add,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
