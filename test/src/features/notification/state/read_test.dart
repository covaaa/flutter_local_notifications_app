import 'package:flutter/services.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../infra/notification_service_test.dart';

void main() {
  late MockNotificationService mockNotificationService;
  late ProviderContainer container;

  setUp(() {
    mockNotificationService = MockNotificationService();
    container = ProviderContainer(
      overrides: [
        notificationServiceProvider.overrideWithValue(mockNotificationService),
      ],
    );
  });

  tearDown(() => container.dispose());

  Future<void> mockInitialize() => mockNotificationService.initialize();

  test('should initialize', () async {
    when(mockInitialize).thenAnswer((_) async {});
    await container.read(readNotificationProvider.notifier).initialize();
    verify(mockInitialize).called(1);
  });

  test('should handle error', () async {
    when(mockInitialize).thenThrow(PlatformException(code: 'some error'));
    final sub = container.listen(readNotificationProvider, (prev, next) {});
    try {
      await container.read(readNotificationProvider.notifier).initialize();
    } on PlatformException catch (error) {
      expect(error, isA<PlatformException>());
      verify(mockInitialize).called(1);
    }
    expect(
      sub.read(),
      isA<AsyncError<void>>().having(
        (e) => e.error,
        'should exception',
        isA<PlatformException>().having(
          (exception) => exception.code,
          'should exception code',
          equals('some error'),
        ),
      ),
    );
  });
}
