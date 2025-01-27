import 'package:flutter/material.dart';

enum NotificationType {
  success,
  warning,
  info,
  error,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final NotificationType type;
  final IconData icon;
  final String? actionRoute;
  final Map<String, dynamic>? actionParams;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    required this.icon,
    this.actionRoute,
    this.actionParams,
    this.isRead = false,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 7) {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'type': type.toString(),
      'icon': icon.codePoint,
      'actionRoute': actionRoute,
      'actionParams': actionParams,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      icon: IconData(json['icon'], fontFamily: 'Iconsax'),
      actionRoute: json['actionRoute'],
      actionParams: json['actionParams'],
      isRead: json['isRead'] ?? false,
    );
  }
}
