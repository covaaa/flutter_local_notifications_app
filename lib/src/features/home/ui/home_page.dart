import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_app/src/features/notification/notification.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        children: const [
          SimpleCard(),
          SizedBox(height: 4),
          ScheduledCard(),
          SizedBox(height: 4),
          UpdatableCard(),
        ],
      ),
    );
  }
}
