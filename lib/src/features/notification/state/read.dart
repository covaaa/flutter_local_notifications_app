import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/infra/easy_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read.g.dart';

@riverpod
class ReadNotification extends _$ReadNotification {
  late EasyNotificationService _service;

  @override
  FutureOr<void> build() async {
    _service = ref.watch(easyNotificationServiceProvider);
  }

  FutureOr<void> show(Notification notification) async {
    return update((_) => _service.createNotification(notification));
  }

  FutureOr<void> showSchedule(Notification notification) async {
    return update((_) => _service.createScheduledNotification(notification));
  }

  FutureOr<void> showUpdatable(Notification notification) async {
    return update((_) => _service.createUpdatableNotification(notification));
  }
}
