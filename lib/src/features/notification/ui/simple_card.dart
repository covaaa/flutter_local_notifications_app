import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/features/notification/state/read.dart';
import 'package:flutter_local_notifications_app/src/shared/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimpleCard extends ConsumerWidget {
  const SimpleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Simple Notification', style: context.titleMediumBold),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                ref.read(readNotificationProvider.notifier).show();
              },
              child: const Text('Show Simple Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
