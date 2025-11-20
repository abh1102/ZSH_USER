
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

class ZendeskService {
  static const String baseUrl = "https://zanaduhealthhelp.zendesk.com";
  static const String email = "support@zanaduhealthhelp.zendesk.com";
  static const String apiToken = "GCEJnVxVaFzibFmMMNrLxIKpQGpIXVSaz8olV5Ss";

  static String get authHeader {
    String creds = "$email/token:$apiToken";
    return "Basic ${base64Encode(utf8.encode(creds))}";
  }

  // Detect MIME type using file extension
  static MediaType _detectMimeType(String path) {
    final ext = path.split(".").last.toLowerCase();

    switch (ext) {
      case "png":
        return MediaType("image", "png");
      case "jpg":
      case "jpeg":
        return MediaType("image", "jpeg");
      case "pdf":
        return MediaType("application", "pdf");
      case "doc":
        return MediaType("application", "msword");
      case "docx":
        return MediaType("application",
            "vnd.openxmlformats-officedocument.wordprocessingml.document");
      default:
        return MediaType("application", "octet-stream");
    }
  }

  /// Upload attachment → return upload token
  static Future<String?> uploadAttachment(File file) async {

    String fileName = file.path.split('/').last;

    final mimeType = _detectMimeType(file.path);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/v2/uploads.json?filename=$fileName"),
    );

    request.headers["Authorization"] = authHeader;

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        file.path,
        contentType: mimeType, // IMPORTANT FIX
      ),
    );

    print("📤 Sending upload request...");

    try {
      var response = await request.send().timeout(const Duration(seconds: 20));
      var respStr = await response.stream.bytesToString();

      print(" Upload Response Code: ${response.statusCode}");
      print("Upload Response Body: $respStr");

      if (response.statusCode == 201) {
        final token = jsonDecode(respStr)["upload"]["token"];
        print(" Upload Success — Token: $token");
        return token;
      } else {
        print("Upload failed: $respStr");
        return null;
      }
    } catch (e) {
      print(" Upload Exception: $e");
      return null;
    }
  }

  /// Create Zendesk ticket
  static Future<bool> createTicket({
    required String category,
    required String description,
    String? uploadToken,
  }) async {
    print("Zendesk Create Ticket API Called");

    final url = Uri.parse("$baseUrl/api/v2/requests.json");

    String? storedEmail = await Preferences.fetchUserEmail();
    final requesterEmail = storedEmail ?? userEmail ?? "support@zanaduhealthhelp.zendesk.com";

    final body = {
      "request": {
        "subject": "Technical Issue - $category",
        "comment": {
          "body": description,
          if (uploadToken != null) "uploads": [uploadToken],
        },
        "requester": {
          "name": storedEmail,
          "email": requesterEmail,
        }
      }
    };

    print("Request Body: ${jsonEncode(body)}");

    try {
      final res = await http
          .post(
        url,
        headers: {
          "Authorization": authHeader,
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 20));

      print("Ticket Response Code: ${res.statusCode}");
      print("Ticket Response Body: ${res.body}");

      if (res.statusCode == 201) {
        print("✅ Ticket Created Successfully!");
        return true;
      }

      print(" Ticket Creation Failed");
      return false;
    } catch (e) {
      print(" Ticket Exception: $e");
      return false;
    }
  }
}
