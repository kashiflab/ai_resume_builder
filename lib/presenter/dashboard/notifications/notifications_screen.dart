import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../domain/entities/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final notifications = [
    NotificationModel(
      id: '1',
      title: 'New Update',
      message: 'A new version of the app is available.',
      createdAt: DateTime.now(),
      type: NotificationType.info,
      icon: Iconsax.info_circle,
    ),
    NotificationModel(
      id: '2',
      title: 'Account Alert',
      message: 'Your account has been successfully updated.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.success,
      icon: Iconsax.tick_circle,
    ),
    NotificationModel(
      id: '3',
      title: 'System Maintenance',
      message: 'The system will be down for maintenance tonight.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.warning,
      icon: Iconsax.warning_2,
    ),
    NotificationModel(
      id: '4',
      title: 'Error Notification',
      message: 'An error occurred while processing your request.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      type: NotificationType.error,
      icon: Iconsax.warning_21,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hasUnread = notifications.any((n) => !n.isRead);
    final groupedNotifications = _groupNotificationsByDate(notifications);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (hasUnread)
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Iconsax.tick_circle),
              label: const Text('Mark all as read'),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.notification,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'ll notify you when something important happens',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedNotifications.length,
              itemBuilder: (context, index) {
                final date = groupedNotifications.keys.elementAt(index);
                final dateNotifications = groupedNotifications[date]!;

                return _buildDateSection(
                  context,
                  date,
                  dateNotifications.map((notification) {
                    return _NotificationItem(
                      title: notification.title,
                      message: notification.message,
                      time: notification.timeAgo,
                      type: notification.type,
                      icon: notification.icon,
                      isRead: notification.isRead,
                      onTap: () {},
                    );
                  }).toList(),
                );
              },
            ),
    );
  }

  Map<String, List<NotificationModel>> _groupNotificationsByDate(
    List<NotificationModel> notifications,
  ) {
    final groupedNotifications = <String, List<NotificationModel>>{};

    for (final notification in notifications) {
      final now = DateTime.now();
      final createdAt = notification.createdAt;
      String dateKey;

      if (createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day) {
        dateKey = 'Today';
      } else if (createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day - 1) {
        dateKey = 'Yesterday';
      } else if (now.difference(createdAt).inDays <= 7) {
        dateKey = 'This Week';
      } else {
        dateKey = '${createdAt.day}/${createdAt.month}/${createdAt.year}';
      }

      groupedNotifications.putIfAbsent(dateKey, () => []);
      groupedNotifications[dateKey]!.add(notification);
    }

    return groupedNotifications;
  }

  Widget _buildDateSection(
    BuildContext context,
    String title,
    List<Widget> notifications,
  ) {
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
        const SizedBox(height: 16),
        ...notifications,
        const SizedBox(height: 24),
      ],
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final IconData icon;
  final VoidCallback onTap;
  final bool isRead;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.icon,
    required this.onTap,
    this.isRead = false,
  });

  Color _getColor() {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.error:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead ? Colors.white : color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isRead ? Colors.grey.shade200 : color.withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
