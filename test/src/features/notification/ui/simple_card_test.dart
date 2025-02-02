import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../extensions/tester_x.dart';

void main() {
  testWidgets(
    'should render simple card',
    (tester) async {
      await tester.pumpApp(child: const SimpleCard());
      expect(find.byType(SimpleCard), findsOneWidget);
    },
  );

  testWidgets(
    'should show simple notification',
    (tester) async {
      await tester.pumpApp(child: const SimpleCard());
      await tester.tap(find.byType(ElevatedButton));
    },
  );
}
