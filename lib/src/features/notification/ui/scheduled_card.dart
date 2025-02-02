import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/shared/theme/theme.dart';

class ScheduledCard extends StatelessWidget {
  const ScheduledCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: const Text('Schedule Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
