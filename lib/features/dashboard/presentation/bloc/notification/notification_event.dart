import 'package:equatable/equatable.dart';
import '../../../data/models/notification_model.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationsEvent extends NotificationEvent {}

class AddNotificationEvent extends NotificationEvent {
  final String title;
  final String message;
  final NotificationType type;
  final String? actionRoute;
  final Map<String, dynamic>? actionParams;

  const AddNotificationEvent({
    required this.title,
    required this.message,
    required this.type,
    this.actionRoute,
    this.actionParams,
  });

  @override
  List<Object?> get props => [title, message, type, actionRoute, actionParams];
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String id;

  const MarkNotificationAsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAllNotificationsAsReadEvent extends NotificationEvent {}

class RemoveNotificationEvent extends NotificationEvent {
  final String id;

  const RemoveNotificationEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ClearAllNotificationsEvent extends NotificationEvent {}
