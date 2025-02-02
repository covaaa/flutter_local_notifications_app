import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/shared/theme/theme.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Simple Notification', style: context.titleMediumBold),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Show Simple Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
