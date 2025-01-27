import 'package:ai_resume_builder/features/dashboard/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification/notification_bloc.dart';
import '../bloc/notification/notification_event.dart';

class NotificationUtils {
  static void showNotification(
    BuildContext context, {
    required String title,
    required String message,
    required NotificationType type,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    context.read<NotificationBloc>().add(
          AddNotificationEvent(
            title: title,
            message: message,
            type: type,
            actionRoute: actionRoute,
            actionParams: actionParams,
          ),
        );
  }

  static void showSuccessNotification(
    BuildContext context, {
    required String title,
    required String message,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    showNotification(
      context,
      title: title,
      message: message,
      type: NotificationType.success,
      actionRoute: actionRoute,
      actionParams: actionParams,
    );
  }

  static void showErrorNotification(
    BuildContext context, {
    required String title,
    required String message,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    showNotification(
      context,
      title: title,
      message: message,
      type: NotificationType.error,
      actionRoute: actionRoute,
      actionParams: actionParams,
    );
  }

  static void showWarningNotification(
    BuildContext context, {
    required String title,
    required String message,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    showNotification(
      context,
      title: title,
      message: message,
      type: NotificationType.warning,
      actionRoute: actionRoute,
      actionParams: actionParams,
    );
  }

  static void showInfoNotification(
    BuildContext context, {
    required String title,
    required String message,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    showNotification(
      context,
      title: title,
      message: message,
      type: NotificationType.info,
      actionRoute: actionRoute,
      actionParams: actionParams,
    );
  }
}
