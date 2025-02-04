import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../extensions/tester_x.dart';
import '../infra/easy_notification_service_test.dart';

void main() {
  late MockEasyNotificationService mockEasyNotificationService;

  setUp(
    () {
      mockEasyNotificationService = MockEasyNotificationService();
      registerFallbackValue(Notification.scheduled(DateTime.now()));
    },
  );

  Future<void> mockCreateScheduledNotification() {
    return mockEasyNotificationService.createScheduledNotification(
      any(that: isA<Notification>()),
    );
  }

  testWidgets(
    'should render scheduled card',
    (tester) async {
      await tester.pumpApp(child: const ScheduledCard());
      expect(find.byType(ScheduledCard), findsOneWidget);
    },
  );

  testWidgets(
    'should show scheduled notification',
    (tester) async {
      when(mockCreateScheduledNotification).thenAnswer((_) async {});
      await tester.pumpApp(
        overrides: [
          easyNotificationServiceProvider.overrideWithValue(
            mockEasyNotificationService,
          ),
        ],
        child: const ScheduledCard(),
      );
      await tester.tap(find.byType(ElevatedButton));
      verify(mockCreateScheduledNotification).called(1);
    },
  );
}
