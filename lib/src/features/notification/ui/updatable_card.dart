import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications_app/src/features/notification/domain/notification.dart';
import 'package:flutter_local_notifications_app/src/features/notification/state/read.dart';
import 'package:flutter_local_notifications_app/src/shared/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdatableCard extends ConsumerWidget {
  const UpdatableCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Updatable Notification', style: context.titleMediumBold),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                final updatable = Notification.updatable();
                final provider = readNotificationProvider;
                ref.read(provider.notifier).showUpdatable(updatable);
              },
              child: const Text('Show Updatable Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
