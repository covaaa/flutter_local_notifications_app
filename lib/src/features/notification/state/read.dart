import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read.g.dart';

@riverpod
class ReadNotification extends _$ReadNotification {
  @override
  FutureOr<void> build() async {}

  FutureOr<void> show() async {
    return update((_) {});
  }

  FutureOr<void> showSchedule() async {
    return update((_) {});
  }

  FutureOr<void> showUpdatable() async {
    return update((_) {});
  }
}
