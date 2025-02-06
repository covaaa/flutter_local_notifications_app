import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest.dart';
import '../../../../extensions/tester_x.dart';

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance
    ..withFakeTimezone()
    ..withFakeLocalNotifications();
  late DateTime date;
  late Notification hello;
  late Notification scheduled;
  late Notification updatable;
  late ProviderContainer container;
  late NotificationService service;

  setUp(
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      AndroidFlutterLocalNotificationsPlugin.registerWith();
      initializeTimeZones();
      date = DateTime.now().add(const Duration(minutes: 1));
      hello = Notification.hello();
      scheduled = Notification.scheduled(date);
      updatable = Notification.updatable();
      container = ProviderContainer();
      service = container.read(notificationServiceProvider);
    },
  );

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
  });

  test(
    'should get props',
    () => expect(service.props, [isA<NotificationAndroid>()]),
  );

  test(
    'should initialize',
    () => expect(service.initialize(), completion(isA<void>())),
  );

  test(
    'should create',
    () => expect(service.createNotification(hello), completion(isA<void>())),
  );

  test(
    'should schedule',
    () => expect(
      service.createScheduledNotification(scheduled),
      completion(isA<void>()),
    ),
  );

  test(
    'should update',
    () => expect(
      service.createUpdatableNotification(updatable),
      completion(isA<void>()),
    ),
  );
}
