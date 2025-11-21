import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

class ZendeskService {
  static const String subdomain = "zanaduhealthhelp.zendesk.com";

  // Agent email MUST match the token creator
  static const String agentEmail = "jb@zanaduhealth.com";
  static const String apiToken = "GCEJnVxVaFzibFmMMNrLxIKpQGpIXVSaz8olV5Ss";

  static String get authHeader {
    final raw = "$agentEmail/token:$apiToken";
    return "Basic ${base64Encode(utf8.encode(raw))}";
  }

  static String? lastUserEmail;

  // MIME
  static MediaType _mime(String path) {
    final ext = path.split(".").last.toLowerCase();
    switch (ext) {
      case "jpg":
      case "jpeg":
        return MediaType("image", "jpeg");
      case "png":
        return MediaType("image", "png");
      case "pdf":
        return MediaType("application", "pdf");
      default:
        return MediaType("application", "octet-stream");
    }
  }

  // -------------------- UPLOAD ATTACHMENT --------------------
  static Future<String?> uploadAttachment(File file) async {
    try {
      final fileName = file.path.split("/").last;

      final request = http.MultipartRequest(
        "POST",
        Uri.parse("https://$subdomain/api/v2/uploads.json?filename=$fileName"),
      );

      request.headers["Authorization"] = authHeader;
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
          contentType: _mime(file.path),
        ),
      );

      final res = await request.send();
      final body = await res.stream.bytesToString();

      if (res.statusCode == 201) {
        return jsonDecode(body)["upload"]["token"];
      }

      print("❌ Upload failed: $body");
      return null;
    } catch (e) {
      print("❌ Upload Error: $e");
      return null;
    }
  }

  // -------------------- CREATE TICKET --------------------
  static Future<bool> createTicket({
    required String category,
    required String description,
    String? uploadToken,
  }) async {
    final url = Uri.parse("https://$subdomain/api/v2/requests.json");

    // Get stored email
    String? userEmail = await Preferences.fetchUserEmail();
    userEmail = userEmail?.trim();

    // Validate email
    if (userEmail == null || userEmail.isEmpty || !userEmail.contains("@")) {
      print("❌ FAILED: Invalid requester email: $userEmail");
      return false;
    }

    lastUserEmail = userEmail;

    print("📨 Creating ticket for: $userEmail");

    final body = {
      "request": {
        "subject": "Technical Issue - $category",
        "requester": {
          "email": userEmail,
          "name": userEmail.split("@")[0],
        },
        "comment": {
          "body": description,
          if (uploadToken != null) "uploads": [uploadToken],
        }
      }
    };

    try {
      final res = await http.post(
        url,
        headers: {
          "Authorization": authHeader,
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      print("📡 CREATE RESPONSE ${res.statusCode} | ${res.body}");

      return res.statusCode == 201;
    } catch (e) {
      print("❌ Create Ticket Error: $e");
      return false;
    }
  }

  // -------------------- FETCH TICKETS --------------------
  static Future<List<dynamic>> fetchTickets() async {
    lastUserEmail ??= (await Preferences.fetchUserEmail())?.trim();

    if (lastUserEmail == null || lastUserEmail!.isEmpty) {
      print("❌ No user email saved — cannot fetch tickets");
      return [];
    }

    final email = lastUserEmail!;
    print("🔍 Fetching tickets for: $email");

    final uri = Uri.https(
      subdomain,
      "/api/v2/search.json",
      {
        "query": "requester:$email type:ticket",
        "sort_by": "created_at",
        "sort_order": "desc",
      },
    );

    try {
      final res = await http.get(
        uri,
        headers: {
          "Authorization": authHeader,
          "Content-Type": "application/json",
        },
      );

      print("📡 FETCH RESPONSE ${res.statusCode}: ${res.body}");

      if (res.statusCode == 200) {
        return jsonDecode(res.body)["results"] ?? [];
      }

      return [];
    } catch (e) {
      print("❌ Fetch Ticket Error: $e");
      return [];
    }
  }
}
