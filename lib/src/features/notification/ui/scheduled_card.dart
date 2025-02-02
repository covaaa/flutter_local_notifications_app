import 'package:flutter/material.dart';
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
            ListTile(
              title: Text(
                'Schedule Time',
                style: context.titleSmall?.copyWith(
                  color: context.theme.hintColor,
                ),
              ),
              subtitle:
                  Text('${DateTime.now()}', style: context.bodyMediumBold),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                ref.read(readNotificationProvider.notifier).showSchedule();
              },
              child: const Text('Schedule Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
