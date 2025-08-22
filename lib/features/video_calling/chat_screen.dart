import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/features/video_calling/logic/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  const ChatScreen({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController messageBoxController = TextEditingController();
  String messageContent = "";

  void showLog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void sendNew() async {
    ChatType type = ChatType.ChatRoom;
    ChatMessage msg = ChatMessage.createTxtSendMessage(
      targetId: widget.chatRoomId,
      content: messageContent,
      chatType: type,
    );

    ChatClient.getInstance.chatManager.sendMessage(msg).then((value) {
      print("Message sent");
    });
  }

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<GroupChatProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Group Chat'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (_, index) {
                    return chatProvider.messages[index];
                  },
                  itemCount: chatProvider.messages.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFD9D9D9), // Set the background color to grey
                    borderRadius:
                        BorderRadius.circular(31.0), // Add border radius
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (msg) => messageContent = msg,
                          controller: messageBoxController,
                          decoration: const InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none, // Remove the underline
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          sendNew();
                          messageBoxController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
