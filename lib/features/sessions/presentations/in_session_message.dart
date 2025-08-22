import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class InSessionMessageScreen extends StatefulWidget {
  const InSessionMessageScreen({
    super.key,
  });

  @override
  State<InSessionMessageScreen> createState() => _InSessionMessageScreenState();
}

class Message {
  final String text;
  final bool isOutgoing;

  Message(this.text, this.isOutgoing);
}

class _InSessionMessageScreenState extends State<InSessionMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [
    Message('Hello', true),
    Message('Hi there!', false),
    Message('How are you?', false),
    Message('I am good, thanks!', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "In-Session",
        secondText: "Message",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Column(
                    children: [
                      SizedBox(height: 8.h), // Add space between messages
                      message.isOutgoing
                          ? Padding(
                              padding: EdgeInsets.only(left: 40.w),
                              child: _buildOutgoingMessage(message.text),
                            )
                          : Padding(
                              padding: EdgeInsets.only(right: 40.w),
                              child: _buildIncomingMessage(message.text),
                            ),
                    ],
                  );
                },
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
                  color: Color(0xFFD9D9D9), // Set the background color to grey
                  borderRadius:
                      BorderRadius.circular(31.0), // Add border radius
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none, // Remove the underline
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        
                        final messageText = _messageController.text;
                        if (messageText.isNotEmpty) {
                          final message = Message(messageText, true);
                          setState(() {
                            messages.add(message);
                          });
                          _messageController.clear();
                          _scrollToBottom();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutgoingMessage(String messageText) {
    return Padding(
      padding: EdgeInsets.only(
        right: 8.w,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: ClipPath(
          clipper: OutgoingMessageClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 17.h,
            ),
            decoration: BoxDecoration(
              gradient: Insets.fixedGradient(opacity: 0.4),
              // Background color for outgoing messages
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Text(messageText),
          ),
        ),
      ),
    );
  }

  Widget _buildIncomingMessage(String messageText) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipPath(
          clipper: IncomingMessageClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 17.h,
            ),
            decoration: const BoxDecoration(
              color:
                  Color(0xFFF0F0F2), // Background color for incoming messages
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
            ),
            child: Text(messageText),
          ),
        ),
      ),
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class OutgoingMessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height); // Create a flat top
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 30.0,
      size.height,
    );
    path.lineTo(0, size.height + 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class IncomingMessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(
      0,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - 30.0,
      size.height,
      size.width,
      size.height,
    );
    path.lineTo(
      size.width,
      size.height - 30.0,
    ); // Create a flat top

    path.lineTo(
      size.width,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
