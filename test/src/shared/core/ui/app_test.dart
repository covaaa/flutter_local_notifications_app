import 'package:flutter_local_notifications_app/src/shared/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should render app',
    (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(App), findsOneWidget);
    },
  );
}
