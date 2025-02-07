import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
part 'notification_android.dart';
part 'notification_ios.dart';
part 'notification_platform.g.dart';

@riverpod
NotificationPlatform notificationPlatform(Ref ref) => NotificationPlatform();

sealed class NotificationMobile extends NotificationPlatform {
  const NotificationMobile._() : super._();
  Future<void> _initializeTimezone() async {
    tz.initializeTimeZones();
    final name = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(name));
    debugPrint('🕐 Timezone initialized: $name');
  }

  @override
  Future<void> initialize() async {
    await _initializeTimezone();
    await _initializePlugin();
  }
}

sealed class NotificationPlatform extends Equatable {
  factory NotificationPlatform() {
    final plugin = FlutterLocalNotificationsPlugin();
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => NotificationAndroid(plugin),
      TargetPlatform.iOS => NotificationIOS(plugin),
      TargetPlatform() => throw UnsupportedError(
          'Platform not supported: $defaultTargetPlatform',
        ),
    };
  }

  const NotificationPlatform._();

  Future<bool> _initializePlugin();
  Future<bool> _askPermission();
  Future<void> _show(Notification notification);
  Future<void> _zonedSchedule(Notification notification);
  Future<void> _update(Notification notification);
  Future<void> initialize();
  Future<void> showNotification(Notification notification) async {
    final permission = await _askPermission();
    debugPrint('Permission: $permission');
    if (!permission) return;
    return _show(notification);
  }

  Future<void> showScheduledNotification(Notification notification) async {
    final permission = await _askPermission();
    debugPrint('Permission: $permission');
    if (!permission) return;
    return _zonedSchedule(notification);
  }

  Future<void> updateNotification(Notification notification) {
    return _update(notification);
  }
}
