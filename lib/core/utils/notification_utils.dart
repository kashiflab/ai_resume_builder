import 'package:ai_resume_builder/domain/entities/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  static void showNotification(
    BuildContext context, {
    required String title,
    required String message,
    required NotificationType type,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {}

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
