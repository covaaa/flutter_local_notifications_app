import 'package:easy_notifications/easy_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'easy_notification_service.g.dart';

@riverpod
EasyNotificationService easyNotificationService(Ref ref) {
  return const EasyNotificationService();
}

class EasyNotificationService {
  const EasyNotificationService();

  Future<void> createNotification(Notification notification) async {
    return EasyNotifications.showMessage(
      title: notification.title,
      body: notification.body,
    );
  }

  Future<void> createScheduledNotification(Notification notification) async {
    return EasyNotifications.scheduleMessage(
      title: notification.title,
      body: notification.body,
      scheduledDate: notification.date!,
    );
  }

  Future<void> createUpdatableNotification(Notification notification) async {
    await createNotification(notification);
    for (var i = 1; i <= 10; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await updateNotification(notification.copyWithRunning(i));
    }
    return updateNotification(notification.copyWithTired());
  }

  Future<void> updateNotification(Notification notification) async {
    return EasyNotifications.updateMessage(
      title: notification.title,
      body: notification.body,
    );
  }
}
