import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingChatbotButton extends StatefulWidget {
  const FloatingChatbotButton({super.key});

  @override
  State<FloatingChatbotButton> createState() => _FloatingChatbotButtonState();
}

class _FloatingChatbotButtonState extends State<FloatingChatbotButton> {
  bool _isChatOpen = false;
  Offset _position = Offset(0, 0);
  bool _isDragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    _position = Offset(size.width - 80.w, size.height - 150.h);
  }

  void _toggleChat() {
    setState(() {
      _isChatOpen = !_isChatOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        if (_isChatOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleChat,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        if (_isChatOpen)
          Positioned(
            right: 20.w,
            bottom: 100.h,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Chat Support',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                            onPressed: _toggleChat,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ChatbotContent(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                _isDragging = true;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _position = Offset(
                  (_position.dx + details.delta.dx).clamp(0.0, size.width - 60.w),
                  (_position.dy + details.delta.dy).clamp(0.0, size.height - 60.h),
                );
              });
            },
            onPanEnd: (details) {
              setState(() {
                _isDragging = false;
              });
            },
            onTap: () {
              if (!_isDragging) {
                _toggleChat();
              }
            },
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isChatOpen ? Icons.close : Icons.chat_bubble,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatbotContent extends StatefulWidget {
  const ChatbotContent({super.key});

  @override
  State<ChatbotContent> createState() => _ChatbotContentState();
}

class _ChatbotContentState extends State<ChatbotContent> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        text: 'Hello! How can I help you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    final userMessage = _messageController.text;
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _getAutoResponse(userMessage),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  String _getAutoResponse(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      return 'Hello! How can I assist you today?';
    } else if (lowerMessage.contains('help')) {
      return 'I\'m here to help! What do you need assistance with?';
    } else if (lowerMessage.contains('thank')) {
      return 'You\'re welcome! Is there anything else I can help you with?';
    } else {
      return 'Thank you for your message. Our support team will get back to you shortly.';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(16.w),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return ChatBubble(message: message);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C63FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(right: 8.w),
              decoration: const BoxDecoration(
                color: Color(0xFF6C63FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF6C63FF)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          if (message.isUser)
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[700],
                size: 18.sp,
              ),
            ),
        ],
      ),
    );
  }
}
