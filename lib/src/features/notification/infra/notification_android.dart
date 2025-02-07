part of 'notification_platform.dart';

typedef _AndroidPlugin = AndroidFlutterLocalNotificationsPlugin;

extension on AndroidNotificationDetails {
  AndroidNotificationDetails toUpdatable() {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      enableLights: enableLights,
      priority: priority,
      importance: importance,
      visibility: visibility,
      icon: icon,
      color: color,
      // Required for updatable notifications
      ongoing: true,
      // Don't play sound on updates
      playSound: false,
      // Show alert only on first notification
      onlyAlertOnce: true,
    );
  }
}

final class NotificationAndroid extends NotificationMobile {
  factory NotificationAndroid(FlutterLocalNotificationsPlugin plugin) {
    const settings = AndroidInitializationSettings('ic_launcher');
    return NotificationAndroid._(
      plugin.resolvePlatformSpecificImplementation<_AndroidPlugin>()!,
      settings: settings,
      details: AndroidNotificationDetails(
        'reminder_channel',
        'Reminder',
        channelDescription: 'Channel for reminder notifications',
        enableLights: true,
        priority: Priority.high,
        importance: Importance.high,
        visibility: NotificationVisibility.public,
        icon: settings.defaultIcon,
        color: Colors.deepPurple,
      ),
    );
  }

  const NotificationAndroid._(
    this.plugin, {
    required this.details,
    required this.settings,
  }) : super._();

  final AndroidNotificationDetails details;
  final AndroidInitializationSettings settings;
  final AndroidFlutterLocalNotificationsPlugin plugin;

  @override
  List<Object?> get props => [details, settings, plugin];

  @override
  Future<bool> _initializePlugin() async {
    final initialized = await plugin.initialize(settings);
    debugPrint('🔔 Android Notification initialized: $initialized');
    return initialized;
  }

  @override
  Future<bool> _askPermission() async {
    final permission = await plugin.requestNotificationsPermission();
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
      scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
