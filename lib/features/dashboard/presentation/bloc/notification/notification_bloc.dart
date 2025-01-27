import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/notification_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  static const String _storageKey = 'notifications';
  final SharedPreferences _prefs;

  NotificationBloc(this._prefs) : super(NotificationInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<AddNotificationEvent>(_onAddNotification);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllNotificationsAsRead);
    on<RemoveNotificationEvent>(_onRemoveNotification);
    on<ClearAllNotificationsEvent>(_onClearAllNotifications);
  }

  IconData _getDefaultIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Iconsax.tick_circle;
      case NotificationType.warning:
        return Iconsax.warning_2;
      case NotificationType.error:
        return Iconsax.close_circle;
      case NotificationType.info:
      default:
        return Iconsax.notification;
    }
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      emit(NotificationLoading());
      final notifications = await _loadNotifications();
      if (notifications.isEmpty) {
        await _initializeDummyNotifications();
        final updatedNotifications = await _loadNotifications();
        emit(NotificationLoaded(updatedNotifications));
      } else {
        emit(NotificationLoaded(notifications));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _initializeDummyNotifications() async {
    final now = DateTime.now();
    final dummyNotifications = [
      NotificationModel(
        id: '1',
        title: 'Welcome to AI Resume Builder!',
        message:
            'Get started by creating your first resume or importing an existing one.',
        createdAt: now.subtract(const Duration(days: 1)),
        type: NotificationType.info,
        icon: _getDefaultIcon(NotificationType.info),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'Premium Features Available',
        message:
            'Unlock advanced AI features and premium templates with our Pro plan.',
        createdAt: now.subtract(const Duration(hours: 12)),
        type: NotificationType.info,
        icon: Iconsax.crown,
        actionRoute: '/settings/subscription',
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Resume Tips Available',
        message:
            'Check out our latest resume writing tips to make your resume stand out!',
        createdAt: now.subtract(const Duration(hours: 6)),
        type: NotificationType.success,
        icon: _getDefaultIcon(NotificationType.success),
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        title: 'New Template Added',
        message:
            'A new professional template has been added to our collection.',
        createdAt: now.subtract(const Duration(hours: 2)),
        type: NotificationType.info,
        icon: Iconsax.document,
        actionRoute: '/templates',
        isRead: false,
      ),
      NotificationModel(
        id: '5',
        title: 'Complete Your Profile',
        message:
            'Add more details to your profile to get personalized resume suggestions.',
        createdAt: now.subtract(const Duration(minutes: 30)),
        type: NotificationType.warning,
        icon: _getDefaultIcon(NotificationType.warning),
        actionRoute: '/settings/profile',
        isRead: false,
      ),
    ];

    final String encoded = jsonEncode(
      dummyNotifications.map((n) => n.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, encoded);
  }

  Future<void> _onAddNotification(
    AddNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationLoaded) {
        final notification = NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: event.title,
          message: event.message,
          createdAt: DateTime.now(),
          type: event.type,
          icon: _getDefaultIcon(event.type),
          actionRoute: event.actionRoute,
          actionParams: event.actionParams,
        );

        final updatedNotifications = [
          notification,
          ...currentState.notifications
        ];
        await _saveNotifications(updatedNotifications);
        emit(NotificationLoaded(updatedNotifications));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationLoaded) {
        final updatedNotifications =
            currentState.notifications.map((notification) {
          if (notification.id == event.id) {
            return NotificationModel(
              id: notification.id,
              title: notification.title,
              message: notification.message,
              createdAt: notification.createdAt,
              type: notification.type,
              icon: notification.icon,
              actionRoute: notification.actionRoute,
              actionParams: notification.actionParams,
              isRead: true,
            );
          }
          return notification;
        }).toList();

        await _saveNotifications(updatedNotifications);
        emit(NotificationLoaded(updatedNotifications));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationLoaded) {
        final updatedNotifications =
            currentState.notifications.map((notification) {
          return NotificationModel(
            id: notification.id,
            title: notification.title,
            message: notification.message,
            createdAt: notification.createdAt,
            type: notification.type,
            icon: notification.icon,
            actionRoute: notification.actionRoute,
            actionParams: notification.actionParams,
            isRead: true,
          );
        }).toList();

        await _saveNotifications(updatedNotifications);
        emit(NotificationLoaded(updatedNotifications));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onRemoveNotification(
    RemoveNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationLoaded) {
        final updatedNotifications = currentState.notifications
            .where((notification) => notification.id != event.id)
            .toList();

        await _saveNotifications(updatedNotifications);
        emit(NotificationLoaded(updatedNotifications));
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onClearAllNotifications(
    ClearAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _saveNotifications([]);
      emit(const NotificationLoaded([]));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<List<NotificationModel>> _loadNotifications() async {
    try {
      final String? storedNotifications = _prefs.getString(_storageKey);
      if (storedNotifications != null) {
        final List<dynamic> decoded = jsonDecode(storedNotifications);
        return decoded.map((json) => NotificationModel.fromJson(json)).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveNotifications(List<NotificationModel> notifications) async {
    final String encoded = jsonEncode(
      notifications.map((n) => n.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, encoded);
  }
}
