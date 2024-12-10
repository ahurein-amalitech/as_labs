import 'dart:async';

import 'package:as_labs/features/chat/models/Message.dart';
import 'package:as_labs/features/chat/models/message_sender.dart';
import 'package:as_labs/utils/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/as_loaders.dart';

class ChatWithJudithController extends GetxController {
  final messageController = TextEditingController();

  final GlobalKey<FormState> chatWithJudithForm = GlobalKey<FormState>();

  final messages = <Message>[].obs;
  final isResponsePending = false.obs;

  final apiService = ApiService();

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) return;

    isResponsePending.value = true;

    final promptMessage = Message(
      sender: UserType.user,
      content: messageController.text,
    );
    messages.add(promptMessage);

    try {
      final payload = {"message": messageController.text};
      final response = await apiService.post("/ai/chat/judith", data: payload);
      messageController.clear();
      final responseContent = response.data["content"] as String;

      final chatMessage = Message(sender: UserType.ai, content: "");
      messages.add(chatMessage);

      await _streamResponseCharacters(responseContent, chatMessage);
    } catch (e) {
      messages.removeLast();
    } finally {
      isResponsePending.value = false;
    }
  }

  Future<void> _streamResponseCharacters(String response, Message chatMessage) async {
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 5));
      chatMessage.content += response[i];
      messages.refresh();
    }
  }

}
