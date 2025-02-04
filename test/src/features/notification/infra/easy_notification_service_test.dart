import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest.dart';

class MockEasyNotificationService extends Mock
    implements EasyNotificationService {}

void main() {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late TestDefaultBinaryMessengerBinding binaryMessengerBinding;
  late DateTime date;
  late Notification hello;
  late Notification scheduled;
  late Notification updatable;
  late ProviderContainer container;
  late EasyNotificationService service;

  setUp(
    () async {
      AndroidFlutterLocalNotificationsPlugin.registerWith();
      TestWidgetsFlutterBinding.ensureInitialized();
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      binaryMessengerBinding = TestDefaultBinaryMessengerBinding.instance;
      binaryMessengerBinding.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'),
        (call) async => switch (call.method) {
          'initialize' => true,
          'zonedSchedule' => <String, Object?>{},
          'show' => <String, Object?>{},
          'cancel' => <String, Object?>{},
          'pendingNotificationRequests' => <Map<String, Object?>>[],
          'getActiveNotifications' => <Map<String, Object?>>[],
          'getNotificationAppLaunchDetails' => null,
          String() => throw UnimplementedError(),
        },
      );
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('ic_launcher'),
        ),
      );
      initializeTimeZones();
      date = DateTime.now().add(const Duration(minutes: 1));
      hello = Notification.hello();
      scheduled = Notification.scheduled(date);
      updatable = Notification.updatable();
      container = ProviderContainer();
      service = container.read(easyNotificationServiceProvider);
    },
  );

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
  });

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
