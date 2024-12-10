import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getX;

import '../../../utils/api_service.dart';
import '../../../utils/as_loaders.dart';
import '../models/Message.dart';
import '../models/message_sender.dart';
import '../models/uploaded_file.dart';

class CvReviewController extends getX.GetxController {
  final message = TextEditingController();

  final GlobalKey<FormState> chatWithJudithForm = GlobalKey<FormState>();

  final messages = <Message>[].obs;
  final isCvUploaded = false.obs;
  final uploadedFiles = <UploadedFile>[].obs;
  final isResponsePending = false.obs;
  final isFilesSubmitting = false.obs;

  final apiService = ApiService();

  sendMessage() async {
    try {
      if (message.text.isEmpty) return;
      isResponsePending.value = true;
      final promptMessage =
          Message(sender: UserType.user, content: message.text);
      messages.add(promptMessage);
      final response = await apiService
          .post("/ai/chat/resumes", data: {"message": message.text});
      final chatMessage =
          Message(sender: UserType.ai, content: response.data["content"]);
      messages.add(chatMessage);
      message.clear();
      await _streamResponseCharacters(response.data["content"], chatMessage);
    } catch (e) {
      messages.removeLast();
    } finally {
      isResponsePending.value = false;
    }
  }

  Future<void> _streamResponseCharacters(
      String response, Message chatMessage) async {
    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 5));
      chatMessage.content += response[i];
      messages.refresh();
    }
  }

  pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      final files = result.files;
      for (var file in files) {
        if (uploadedFiles.contains(file.name) || file?.path == null) return;
        uploadedFiles.add(UploadedFile(fileName: file.name, path: file.path));
        print("Picked file: ${file.name} (${file.path})");
      }
    }
  }

  uploadFiles() async {
    isFilesSubmitting.value = true;
    FormData formData = FormData();
    for (var file in uploadedFiles) {
      final fileObject = File(file.path!);
      formData.files.add(MapEntry(
          "files",
          await MultipartFile.fromFile(fileObject.path,
              filename: fileObject.uri.pathSegments.last)));
    }

    final response = await apiService.post("/ai/upload", data: formData);
    AsLoaders.successSnackBar(title: response.data["message"]);
    isCvUploaded.value = true;
    isFilesSubmitting.value = false;
    final promptMessage =
    Message(sender: UserType.user, content: "CV(s) uploaded 🚀");
    messages.add(promptMessage);

    final aiMessageBody = """
    CV(s) uploaded: ${uploadedFiles.length}
    CV(s) analyzed: ${uploadedFiles.length}
    CV file names: ${(uploadedFiles.map((f) => f.fileName).join(", "))}
    """;
    final aiResponseMessage =
    Message(sender: UserType.ai, content: aiMessageBody);
    messages.add(aiResponseMessage);
  }
}
