import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart';
import '../../../../extensions/tester_x.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TestDefaultBinaryMessengerBinding binding;
  late DateTime date;
  late Notification hello;
  late Notification scheduled;
  late Notification updatable;
  late ProviderContainer container;
  late NotificationPlatform platform;

  setUp(
    () {
      binding = TestDefaultBinaryMessengerBinding.instance
        ..setUpFakeLocalNotifications();
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      AndroidFlutterLocalNotificationsPlugin.registerWith();
      initializeTimeZones();
      date = DateTime.now().add(const Duration(minutes: 1));
      hello = Notification.hello();
      scheduled = Notification.scheduled(date);
      updatable = Notification.updatable();
      container = ProviderContainer();
      platform = container.read(notificationPlatformProvider);
    },
  );

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
    binding.setUpNull();
  });

  test(
    'should get props',
    () => expect(
      platform.props,
      equals([
        isA<AndroidNotificationDetails>(),
        isA<AndroidInitializationSettings>(),
        isA<AndroidFlutterLocalNotificationsPlugin>(),
      ]),
    ),
  );

  test(
    'should initialize',
    () => expect(platform.initialize(), completion(isTrue)),
  );

  test(
    'should show notification',
    () => expect(platform.showNotification(hello), completion(isA<void>())),
  );

  test(
    'should schedule notification',
    () => expect(
      platform.showScheduledNotification(scheduled),
      completion(isA<void>()),
    ),
  );

  test(
    'should update notification',
    () => expect(
      platform.updateNotification(updatable),
      completion(isA<void>()),
    ),
  );
}
