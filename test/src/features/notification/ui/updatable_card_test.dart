import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../extensions/tester_x.dart';

void main() {
  testWidgets(
    'should render updatable card',
    (tester) async {
      await tester.pumpApp(child: const UpdatableCard());
      expect(find.byType(UpdatableCard), findsOneWidget);
    },
  );

  testWidgets(
    'should show updatable notification',
    (tester) async {
      await tester.pumpApp(child: const UpdatableCard());
      await tester.tap(find.byType(ElevatedButton));
    },
  );
}
