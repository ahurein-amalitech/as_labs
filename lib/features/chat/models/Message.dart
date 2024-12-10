import 'package:as_labs/features/chat/models/message_sender.dart';

class Message {
  final UserType sender;
  String content;

  Message({required this.sender, required this.content});
}