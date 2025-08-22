
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

Future<void> myLaunchUrl(String url) async {
  /// const baseUrl = imgUrl; // Replace with your base URL
  //final completeUrl = '$baseUrl$url';
  final completeUrl = url;
  if (Platform.isIOS) {
    if (!await launchUrl(Uri.parse(completeUrl))) {
      throw Exception('Could not launch $completeUrl');
    }
  } else {
    if (!await launchUrl(Uri.parse(completeUrl),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $completeUrl');
    }
  }
}
