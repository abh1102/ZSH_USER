import 'package:flutter/material.dart';

class TabIndexProvider extends ChangeNotifier {
  int initialTabIndex = 0;

  void setInitialTabIndex(int index) {
    initialTabIndex = index;
    notifyListeners();
  }
}
