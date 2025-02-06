import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/infra/notification_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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

  Future<void> initialize() async {
    return switch (platform) {
      NotificationMobile() => () async {
          tz.initializeTimeZones();
          final name = await FlutterTimezone.getLocalTimezone();
          debugPrint('🕐 Timezone initialized: $name');
          tz.setLocalLocation(tz.getLocation(name));
          final initialized = await platform.initialize();
          debugPrint('🔔 Notification initialized: $initialized');
        }(),
    };
  }

  Future<void> createNotification(Notification notification) async {
    return platform.showNotification(notification);
  }

  Future<void> createScheduledNotification(Notification notification) async {
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

  Future<void> updateNotification(Notification notification) async {
    return platform.updateNotification(notification);
  }
}
