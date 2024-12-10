import 'package:as_labs/features/chat/controller/chat_with_judith_controller.dart';
import 'package:as_labs/features/chat/controller/cv_review_controller.dart';
import 'package:as_labs/features/chat/controller/query_pdf_controller.dart';
import 'package:as_labs/features/chat/models/message_sender.dart';
import 'package:as_labs/utils/colors.dart';
import 'package:as_labs/utils/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class QueryFileChat extends StatelessWidget {
  const QueryFileChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = QueryPdfController();

    return Scaffold(
        backgroundColor: AsColors.black,
        appBar: _buildAppBar(context),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AsDeviceUtils.getAdaptiveResponsivePadding(context)),
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final message = controller.messages[index];
                            return message.sender == UserType.ai
                                ? _buildAIMessage(
                                context, message.content)
                                : _buildUserMessage(
                                context, message.content);
                          },
                          childCount: controller.messages.length,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildMessageInput(controller),
                const SizedBox(height: 63),
              ],
            ),
          );
        }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AsColors.black,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Iconsax.arrow_left, color: Colors.white),
      ),
      title: Text(
        "Query Pdf",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget _buildMessageList(
      BuildContext context, ChatWithJudithController controller) {
    return ListView.builder(
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        if (message.sender == UserType.ai) {
          return _buildAIMessage(context, message.content);
        } else {
          return _buildUserMessage(context, message.content);
        }
      },
    );
  }

  Widget _buildAIMessage(BuildContext context, String content) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AsColors.inputBackground,
          ),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildUserMessage(BuildContext context, String content) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: AsDeviceUtils.getScreenWidth(context) * 0.2),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AsColors.inputBackground,
                ),
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildMessageInput(QueryPdfController controller) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AsColors.inputBackground,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.message,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: "Write something...",
                border: InputBorder.none,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),

            ),
          ),
          _buildSendButtonOrLoader(controller)
        ],
      ),
    );
  }

  Widget _buildSendButtonOrLoader(QueryPdfController controller) {
    return controller.isResponsePending.value
        ? const Padding(
      padding: EdgeInsets.only(right: 15),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(color: AsColors.white),
      ),
    )
        : Row(
      children: [
        IconButton(
          icon: const Icon(Icons.upload_file, color: Colors.white),
          onPressed: () => controller.pickAndUploadFileInChat(),
        ),
        const SizedBox(height: 5),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.white),
          onPressed: () => controller.sendMessage(),
        )
      ],
    );
  }
}
