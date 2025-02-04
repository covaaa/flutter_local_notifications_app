import 'package:flutter_local_notifications_app/src/features/home/home.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../extensions/tester_x.dart';
import '../../notification/infra/easy_notification_service_test.dart';

void main() {
  late MockEasyNotificationService mockEasyNotificationService;

  setUp(
    () {
      TestWidgetsFlutterBinding.ensureInitialized();
      mockEasyNotificationService = MockEasyNotificationService();
    },
  );

  testWidgets(
    'should render home page',
    (tester) async {
      await tester.pumpApp(
        overrides: [
          easyNotificationServiceProvider.overrideWithValue(
            mockEasyNotificationService,
          ),
        ],
        child: const HomePage('Flutter Local Notifications App'),
      );
      await tester.pump();
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(SimpleCard), findsOneWidget);
      expect(find.byType(ScheduledCard), findsOneWidget);
      expect(find.byType(UpdatableCard), findsOneWidget);
    },
  );
}
