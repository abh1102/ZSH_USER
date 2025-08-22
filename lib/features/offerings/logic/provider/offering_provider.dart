import 'package:flutter/material.dart';

class OfferingProvider extends ChangeNotifier {
  bool isOfferSelected = false;

  void changeOfferSelected(bool mybool) {
    isOfferSelected = mybool;
    notifyListeners();
  }
}
