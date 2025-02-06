import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart';
import '../../../../extensions/tester_x.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.withFakeLocalNotifications();
  late ProviderContainer container;

  setUp(
    () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      MacOSFlutterLocalNotificationsPlugin.registerWith();
      initializeTimeZones();
      container = ProviderContainer();
    },
  );

  tearDown(() {
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
  });

  test(
    'should throw unsupported error',
    () => expect(
      () => container.read(notificationPlatformProvider),
      throwsUnsupportedError,
    ),
  );
}
