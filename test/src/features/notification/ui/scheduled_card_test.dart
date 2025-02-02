import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../extensions/tester_x.dart';

void main() {
  testWidgets(
    'should render scheduled card',
    (tester) async {
      await tester.pumpApp(child: const ScheduledCard());
      expect(find.byType(ScheduledCard), findsOneWidget);
    },
  );

  testWidgets(
    'should show date time picker',
    (tester) async {
      await tester.pumpApp(child: const ScheduledCard());
      await tester.tap(find.byType(IconButton));
    },
  );

  testWidgets(
    'should show scheduled notification',
    (tester) async {
      await tester.pumpApp(child: const ScheduledCard());
      await tester.tap(find.byType(ElevatedButton));
    },
  );
}
