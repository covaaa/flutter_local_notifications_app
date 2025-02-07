part of 'notification_platform.dart';

typedef _IOSPlugin = IOSFlutterLocalNotificationsPlugin;
typedef _UI = UILocalNotificationDateInterpretation;

extension on DarwinNotificationDetails {
  DarwinNotificationDetails toUpdatable() {
    return DarwinNotificationDetails(
      presentAlert: presentAlert,
      presentBadge: presentBadge,
      // Don't play sound on updates
      presentSound: false,
    );
  }
}

final class NotificationIOS extends NotificationMobile {
  factory NotificationIOS(FlutterLocalNotificationsPlugin plugin) {
    return NotificationIOS._(
      plugin.resolvePlatformSpecificImplementation<_IOSPlugin>()!,
      details: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  const NotificationIOS._(this.plugin, {required this.details}) : super._();

  final DarwinNotificationDetails details;
  final IOSFlutterLocalNotificationsPlugin plugin;

  @override
  List<Object?> get props => [details, plugin];

  @override
  Future<bool> _initializePlugin() async {
    final initialized = await plugin.initialize(
      const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    debugPrint('🔔 iOS Notification initialized: $initialized');
    return initialized ?? false;
  }

  @override
  Future<bool> _askPermission() async {
    final permission = await plugin.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return permission ?? false;
  }

  @override
  Future<void> _show(Notification notification) async {
    return plugin.show(
      1,
      notification.title,
      notification.body,
      notificationDetails: details,
    );
  }

  @override
  Future<void> _zonedSchedule(Notification notification) async {
    return plugin.zonedSchedule(
      1,
      notification.title,
      notification.body,
      tz.TZDateTime.from(notification.date!, tz.local),
      details,
      uiLocalNotificationDateInterpretation: _UI.absoluteTime,
    );
  }

  @override
  Future<void> _update(Notification notification) async {
    return plugin.show(
      1,
      notification.title,
      notification.body,
      notificationDetails: details.toUpdatable(),
    );
  }
}
