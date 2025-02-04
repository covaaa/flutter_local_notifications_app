import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/state/read.dart';
import 'package:flutter_local_notifications_app/src/shared/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduledCard extends ConsumerWidget {
  const ScheduledCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scheduled Notification', style: context.titleMediumBold),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                final date = DateTime.now().add(const Duration(seconds: 5));
                final schedule = Notification.scheduled(date);
                final provider = readNotificationProvider;
                ref.read(provider.notifier).showSchedule(schedule);
              },
              child: const Text('Schedule Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
