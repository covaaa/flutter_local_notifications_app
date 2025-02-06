import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/infra/notification_service.dart';
import 'package:flutter_local_notifications_app/src/shared/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read.g.dart';

@riverpod
class ReadNotification extends _$ReadNotification with Load {
  late NotificationService _service;

  @override
  FutureOr<void> build() async {
    _service = ref.watch(notificationServiceProvider);
  }

  FutureOr<void> initialize() async {
    return super.load(_service.initialize);
  }

  FutureOr<void> show(Notification notification) async {
    return super.load(() => _service.createNotification(notification));
  }

  FutureOr<void> showSchedule(Notification notification) async {
    return super.load(() => _service.createScheduledNotification(notification));
  }

  FutureOr<void> showUpdatable(Notification notification) async {
    return super.load(() => _service.createUpdatableNotification(notification));
  }
}
