// Utility function to convert UTC time to IST
import 'package:intl/intl.dart';

DateTime convertUtcToIst(String utcTime) {
  DateTime utcDateTime = DateTime.parse(utcTime).toUtc();
  Duration offset = DateTime.now().timeZoneOffset;
  return utcDateTime.add(offset);
}

// Utility function to check if the session is joinable

bool isSessionJoinable(String date) {
  if (date.isEmpty) {
    return false;
  }
  DateTime startDate = DateTime.parse(date);
  DateTime localStartDate = startDate.toLocal();
  Duration difference = localStartDate.difference(DateTime.now());

// Check if the difference is less than 30 minutes
  bool isStartNow = difference.inMinutes < 5;

  return isStartNow;
}

String myformattedDate(String date) {
  if (date.isEmpty) {
    return "";
  }
  DateTime startDate = DateTime.parse(date);
  DateTime localStartDate = startDate.toLocal();
  String formattedDate = DateFormat('MM-dd-yyyy').format(localStartDate);
  return formattedDate;
}

String myformattedTime(String date) {
  if (date.isEmpty) {
    return "";
  }
  DateTime startDate = DateTime.parse(date);
  DateTime localStartDate = startDate.toLocal();
  String formattedTime = DateFormat.jm().format(localStartDate);
  return formattedTime;
}
