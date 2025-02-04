import 'package:equatable/equatable.dart';

final class Notification extends Equatable {
  const Notification._({required this.title, required this.body, this.date});

  factory Notification.hello() {
    return const Notification._(
      title: 'Hello! 👋',
      body: 'This is a simple notification',
    );
  }

  factory Notification.scheduled(DateTime date) {
    return Notification._(
      title: 'Time to Feed! ⏰',
      body: "Don't forget to feed your hamster!",
      date: date,
    );
  }

  factory Notification.updatable() {
    return const Notification._(
      title: 'Hamster is Playing! 🐹',
      body: 'Activity: 0%',
    );
  }

  final String title;
  final String body;
  final DateTime? date;

  @override
  List<Object?> get props => [title, body, date];

  Notification copyWith({String? title, String? body, DateTime? date}) {
    return Notification._(
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
    );
  }

  Notification copyWithRunning(int i) {
    return copyWith(
      title: 'Hamster is Running! 🏃',
      body: 'Activity: ${i * 10}%',
    );
  }

  Notification copyWithTired() {
    return copyWith(title: 'Hamster is Tired! 😴', body: 'Time to rest');
  }
}
