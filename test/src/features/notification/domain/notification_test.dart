import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should get props',
    () => expect(
      Notification.hello().props,
      ['Hello! 👋', 'This is a simple notification', null],
    ),
  );

  test(
    'should copy with',
    () => expect(Notification.hello().copyWith(), Notification.hello()),
  );
}
