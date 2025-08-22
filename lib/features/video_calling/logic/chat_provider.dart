import 'package:flutter/material.dart';

class GroupChatProvider extends ChangeNotifier {
  List<Widget> messages = [];

  void addGroupMessage(Widget message) {
    messages.add(message);
    notifyListeners();
  }

  void clear() {
    messages = [];
    notifyListeners();
  }
}
