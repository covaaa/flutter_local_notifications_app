import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../extensions/tester_x.dart';
import '../infra/notification_service_test.dart';

void main() {
  late MockNotificationService mockNotificationService;

  setUp(() {
    mockNotificationService = MockNotificationService();
    registerFallbackValue(Notification.hello());
  });

  Future<void> mockCreateNotification() {
    return mockNotificationService.createNotification(
      any(that: isA<Notification>()),
    );
  }

  testWidgets('should render simple card', (tester) async {
    await tester.pumpApp(child: const SimpleCard());
    expect(find.byType(SimpleCard), findsOneWidget);
  });

  testWidgets('should show simple notification', (tester) async {
    when(mockCreateNotification).thenAnswer((_) async {});
    await tester.pumpApp(
      overrides: [
        notificationServiceProvider.overrideWithValue(mockNotificationService),
      ],
      child: const SimpleCard(),
    );
    await tester.tap(find.byType(ElevatedButton));
    verify(mockCreateNotification).called(1);
  });
}
