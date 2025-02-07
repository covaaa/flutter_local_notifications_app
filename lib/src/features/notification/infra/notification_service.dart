import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/infra/notification_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'notification_service.g.dart';

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService(ref.watch(notificationPlatformProvider));
}

class NotificationService extends Equatable {
  const NotificationService(this.platform);

  final NotificationPlatform platform;

  @override
  List<NotificationPlatform> get props => [platform];

  Future<void> initialize() => platform.initialize();

  Future<void> createNotification(Notification notification) {
    return platform.showNotification(notification);
  }

  Future<void> createScheduledNotification(Notification notification) {
    return platform.showScheduledNotification(notification);
  }

  Future<void> createUpdatableNotification(Notification notification) async {
    await createNotification(notification);
    for (var i = 1; i <= 10; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await updateNotification(notification.copyWithRunning(i));
    }
    return updateNotification(notification.copyWithTired());
  }

  Future<void> updateNotification(Notification notification) {
    return platform.updateNotification(notification);
  }
}
