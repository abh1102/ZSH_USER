import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  final BuildContext context;
  SessionProvider(this.context);

  DateTime? startDate;
  DateTime? endDate;

  void pickStartDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
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
}
