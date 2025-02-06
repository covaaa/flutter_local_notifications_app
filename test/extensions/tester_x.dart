import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpRiverpodWidget({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return pumpWidget(ProviderScope(overrides: overrides, child: child));
  }

  Future<void> pumpApp({
    required Widget child,
    bool scaffold = true,
    List<Override> overrides = const [],
  }) async {
    return pumpRiverpodWidget(
      overrides: overrides,
      child: MaterialApp(home: scaffold ? Scaffold(body: child) : child),
    );
  }
}

extension TestDefaultBinaryMessengerBindingX
    on TestDefaultBinaryMessengerBinding {
  void withFakeLocalNotifications() {
    return defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('dexterous.com/flutter/local_notifications'),
      (call) async => switch (call.method) {
        'initialize' => true,
        // for iOS
        'requestPermissions' => true,
        // for Android
        'requestNotificationsPermission' => true,
        'show' => <String, Object?>{},
        'cancel' => <String, Object?>{},
        'zonedSchedule' => <String, Object?>{},
        'pendingNotificationRequests' => <Map<String, Object?>>[],
        'getActiveNotifications' => <Map<String, Object?>>[],
        'getNotificationAppLaunchDetails' => null,
        String() => () {
            debugPrint('Unexpected method: ${call.method}');
            throw UnimplementedError('Unexpected method: ${call.method}');
          }(),
      },
    );
  }

  void withFakeTimezone() {
    return defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('flutter_timezone'),
      (call) async => switch (call.method) {
        'getLocalTimezone' => 'Asia/Tokyo',
        String() => () {
            debugPrint('Unexpected method: ${call.method}');
            throw UnimplementedError('Unexpected method: ${call.method}');
          }(),
      },
    );
  }
}
