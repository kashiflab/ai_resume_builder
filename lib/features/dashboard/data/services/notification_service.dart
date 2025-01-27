import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationService extends ChangeNotifier {
  static const String _storageKey = 'notifications';
  final SharedPreferences _prefs;
  List<NotificationModel> _notifications = [];
  bool _isInitialized = false;

  NotificationService(this._prefs);

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> init() async {
    if (_isInitialized) return;
    await _loadNotifications();
    _isInitialized = true;
  }

  Future<void> _loadNotifications() async {
    final String? storedNotifications = _prefs.getString(_storageKey);
    if (storedNotifications != null) {
      final List<dynamic> decoded = jsonDecode(storedNotifications);
      _notifications = decoded
          .map((json) => NotificationModel.fromJson(json))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    }
  }

  Future<void> _saveNotifications() async {
    final String encoded = jsonEncode(
      _notifications.map((n) => n.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, encoded);
  }

  void addNotification({
    required String title,
    required String message,
    required NotificationType type,
    IconData? icon,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      createdAt: DateTime.now(),
      type: type,
      icon: icon ?? _getDefaultIcon(type),
      actionRoute: actionRoute,
      actionParams: actionParams,
    );

    _notifications.insert(0, notification);
    _saveNotifications();
    notifyListeners();
  }

  IconData _getDefaultIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Iconsax.tick_circle;
      case NotificationType.warning:
        return Iconsax.warning_2;
      case NotificationType.info:
        return Iconsax.info_circle;
      case NotificationType.error:
        return Iconsax.close_circle;
    }
  }

  void markAsRead(String id) {
    final notification = _notifications.firstWhere((n) => n.id == id);
    notification.isRead = true;
    _saveNotifications();
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    _saveNotifications();
    notifyListeners();
  }

  void removeNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    _saveNotifications();
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    _saveNotifications();
    notifyListeners();
  }
}
