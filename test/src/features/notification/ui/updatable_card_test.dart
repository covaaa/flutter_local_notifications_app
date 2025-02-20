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
    registerFallbackValue(Notification.updatable());
  });

  Future<void> mockCreateUpdatableNotification() {
    return mockNotificationService.createUpdatableNotification(
      any(that: isA<Notification>()),
    );
  }

  testWidgets('should render updatable card', (tester) async {
    await tester.pumpApp(child: const UpdatableCard());
    expect(find.byType(UpdatableCard), findsOneWidget);
  });

  testWidgets('should show updatable notification', (tester) async {
    when(mockCreateUpdatableNotification).thenAnswer((_) async {});
    await tester.pumpApp(
      overrides: [
        notificationServiceProvider.overrideWithValue(mockNotificationService),
      ],
      child: const UpdatableCard(),
    );
    await tester.tap(find.byType(ElevatedButton));
    verify(mockCreateUpdatableNotification).called(1);
    await tester.pumpAndSettle();
  });
}
