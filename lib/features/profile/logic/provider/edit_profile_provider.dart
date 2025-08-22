import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider with ChangeNotifier {
  final BuildContext context;
  EditProfileProvider(this.context);

  DateTime? startDate;
  DateTime? endDate;

  void pickStartDate() async {
    final currentDate = DateTime.now();
    final minimumDate =
        DateTime(currentDate.year - 21, currentDate.month, currentDate.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: minimumDate,
      firstDate: DateTime(1920),
      lastDate: minimumDate,
    );

    if (pickedDate != null) {
      setStartDate(pickedDate);
    }
    notifyListeners();
  }

  void setStartDate(DateTime start) {
    startDate = start;
    notifyListeners();
  }

  bool isLoading = false;
  String error = "";
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print("Error picking image: $e");
      // Handle the error or show a user-friendly error message.
    }
  }

  void setUploadImagePath(XFile myFile) {
    selectedImage = File(myFile.path);
    notifyListeners();
  }

  void removeSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }
}
