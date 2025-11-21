import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

class ZendeskService {
  // BASE ZENDESK CONFIG
  static const String subdomain = "zanaduhealthhelp.zendesk.com";

  // MUST MATCH THE AGENT WHO CREATED THE TOKEN
  static const String agentEmail = "jb@zanaduhealth.com";
  static const String apiToken = "GCEJnVxVaFzibFmMMNrLxIKpQGpIXVSaz8olV5Ss";

  static String get authHeader {
    final raw = "$agentEmail/token:$apiToken";
    return "Basic ${base64Encode(utf8.encode(raw))}";
  }

  static String? lastUserEmail;

  // ------------------------------------------------------
  // MIME TYPE
  // ------------------------------------------------------
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

  // ------------------------------------------------------
  // UPLOAD ATTACHMENT
  // ------------------------------------------------------
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
      print("❌ Upload Exception: $e");
      return null;
    }
  }

  // ------------------------------------------------------
  // CREATE TICKET (FIXED)
  // ------------------------------------------------------
  static Future<bool> createTicket({
    required String category,
    required String description,
    String? uploadToken,
  }) async {
    final url = Uri.parse("https://$subdomain/api/v2/requests.json");

    // Logged-in user email
    String? userEmail = await Preferences.fetchUserEmail();
    userEmail = userEmail?.trim();

    if (userEmail == null || userEmail.isEmpty) {
      print("❌ Cannot create ticket — no user email available");
      return false;
    }

    lastUserEmail = userEmail;

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
          "X-On-Behalf-Of": userEmail, // IMPORTANT FIX 🚀
        },
        body: jsonEncode(body),
      );

      print("📡 CREATE: ${res.statusCode} | ${res.body}");

      return res.statusCode == 201;
    } catch (e) {
      print("❌ Create Ticket Error: $e");
      return false;
    }
  }

  // ------------------------------------------------------
  // FETCH TICKETS FOR THAT USER ONLY
  // ------------------------------------------------------
  static Future<List<dynamic>> fetchTickets() async {
    lastUserEmail ??= (await Preferences.fetchUserEmail())?.trim();

    if (lastUserEmail == null) {
      print("❌ Cannot fetch tickets — no user email stored");
      return [];
    }

    final uri = Uri.https(
      subdomain,
      "/api/v2/search.json",
      {
        "query": "requester:$lastUserEmail type:ticket",
        "sort_by": "created_at",
        "sort_order": "desc",
      },
    );

    print("🔍 Fetch URL: $uri");

    try {
      final res = await http.get(
        uri,
        headers: {
          "Authorization": authHeader,
          "Content-Type": "application/json",
        },
      );

      print("📡 FETCH: ${res.statusCode}");
      print("📡 RESPONSE: ${res.body}");

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
