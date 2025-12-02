import 'user.dart';

class Message {
  final String id;
  final User from;
  final User to;
  final String text;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.from,
    required this.to,
    required this.text,
    required this.timestamp,
  });
}
