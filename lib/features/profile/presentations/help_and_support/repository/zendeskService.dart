// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:image/image.dart' as img;
//
// class ZendeskService {
//
//   static const String subdomain = "zanaduhealthhelp.zendesk.com";
//   static const String email = "support@zanaduhealth.com";
//   static const String apiToken = "GCEJnVxVaFzibFmMMNrLxIKpQGpIXVSaz8olV5Ss";
//
//   static String? _userEmailForSearch;
//
//   static String get _authHeader {
//     final raw = "$email/token:$apiToken";
//     final encoded = base64Encode(utf8.encode(raw));
//     return "Basic $encoded";
//   }
//
//   static Future<File> _forceConvertToRealJpeg(File file) async {
//     try {
//       final bytes = await file.readAsBytes();
//       final decoded = img.decodeImage(bytes);
//
//       if (decoded == null) return file;
//
//       final jpgBytes = img.encodeJpg(decoded, quality: 90);
//       final newPath = file.path.replaceAll(".jpg", "_fixed.jpg");
//       final newFile = File(newPath)..writeAsBytesSync(jpgBytes);
//       return newFile;
//
//     } catch (_) {
//       return file;
//     }
//   }
//
//   static Future<String?> uploadAttachment(String filePath) async {
//     try {
//       File file = File(filePath);
//       String ext = file.path.split('.').last.toLowerCase();
//
//       // Xiaomi internal JPEG fix
//       if (ext == "jpg" || ext == "jpeg") {
//         file = await _forceConvertToRealJpeg(file);
//       }
//
//       // MIME type
//       MediaType contentType;
//       if (ext == "jpg" || ext == "jpeg") {
//         contentType = MediaType("image", "jpeg");
//       } else if (ext == "png") {
//         contentType = MediaType("image", "png");
//       } else if (ext == "pdf") {
//         contentType = MediaType("application", "pdf");
//       } else {
//         print("Unsupported file type");
//         return null;
//       }
//
//       final uri = Uri.https(
//         subdomain,
//         "/api/v2/uploads.json",
//         {"filename": file.path.split('/').last},
//       );
//
//       final request = http.MultipartRequest("POST", uri)
//         ..headers["Authorization"] = _authHeader
//         ..files.add(await http.MultipartFile.fromPath(
//           "file",
//           file.path,
//           contentType: contentType,
//         ));
//
//       final response = await request.send();
//       final body = await response.stream.bytesToString();
//
//       if (response.statusCode == 201) {
//         final data = jsonDecode(body);
//         return data["upload"]["token"];
//       }
//
//       print("❌ Upload failed → ${response.statusCode}");
//       print(body);
//       return null;
//
//     } catch (e) {
//       print("❌ Upload ERROR: $e");
//       return null;
//     }
//   }
//
//   // -----------------------------------------
//   // 2️⃣ CREATE TICKET
//   // -----------------------------------------
//   static Future<Map<String, dynamic>?> createTicket({
//     required String userName,
//     required String userEmail,
//     required String category,
//     required String description,
//     String? uploadToken,
//   }) async {
//
//     final uri = Uri.https(subdomain, "/api/v2/requests.json");
//
//     // Save the email for fetchTickets()
//     _userEmailForSearch = userEmail;
//
//     final Map<String, dynamic> body = {
//       "request": {
//         "requester": {"name": userName, "email": userEmail},
//         "subject": "Payment Issue - $category",
//         "comment": {"body": description},
//       }
//     };
//
//     if (uploadToken != null) {
//       body["request"]!["uploads"] = [uploadToken];
//     }
//
//     final response = await http.post(
//       uri,
//       headers: {
//         "Authorization": _authHeader,
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode(body),
//     );
//
//     print("📡 CREATE STATUS: ${response.statusCode}");
//     print("📡 CREATE RESPONSE: ${response.body}");
//
//     if (response.statusCode == 201) {
//       return jsonDecode(response.body)["request"];
//     }
//
//     return null;
//   }
//
//   // -----------------------------------------
//   // 3️⃣ FETCH TICKETS (via email search)
//   // -----------------------------------------
//   static Future<List<dynamic>> fetchTickets() async {
//     if (_userEmailForSearch == null) {
//       print("❌ No user email stored — cannot fetch.");
//       return [];
//     }
//
//     final uri = Uri.https(
//       subdomain,
//       "/api/v2/search.json",
//       {
//         "query": "via.email:${_userEmailForSearch} type:ticket",
//         "sort_by": "created_at",
//         "sort_order": "desc",
//       },
//     );
//
//     final response = await http.get(
//       uri,
//       headers: {
//         "Authorization": _authHeader,
//         "Content-Type": "application/json",
//       },
//     );
//
//     print("📡 FETCH STATUS: ${response.statusCode}");
//     print("📡 FETCH RESPONSE: ${response.body}");
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["results"] ?? [];
//     }
//
//     return [];
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ZendeskService {
  static const String baseUrl = "https://zanaduhealthhelp.zendesk.com";
  static const String email = "support@zanaduhealth.com";
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
    print("➡️ Zendesk Upload API Called");
    print("📄 Uploading File: ${file.path}");

    String fileName = file.path.split('/').last;

    final mimeType = _detectMimeType(file.path);
    print("📝 Detected MIME: $mimeType");

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

      print("📥 Upload Response Code: ${response.statusCode}");
      print("📥 Upload Response Body: $respStr");

      if (response.statusCode == 201) {
        final token = jsonDecode(respStr)["upload"]["token"];
        print("✅ Upload Success — Token: $token");
        return token;
      } else {
        print("❌ Upload failed: $respStr");
        return null;
      }
    } catch (e) {
      print("🔥 Upload Exception: $e");
      return null;
    }
  }

  /// Create Zendesk ticket
  static Future<bool> createTicket({
    required String category,
    required String description,
    String? uploadToken,
  }) async {
    print("➡️ Zendesk Create Ticket API Called");

    final url = Uri.parse("$baseUrl/api/v2/requests.json");

    final body = {
      "request": {
        "subject": "Technical Issue - $category",
        "comment": {
          "body": description,
          if (uploadToken != null) "uploads": [uploadToken],
        },
        "requester": {
          "email": email, // REQUIRED BY ZENDESK
        }
      }
    };

    print("📦 Request Body: ${jsonEncode(body)}");

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

      print("📥 Ticket Response Code: ${res.statusCode}");
      print("📥 Ticket Response Body: ${res.body}");

      if (res.statusCode == 201) {
        print("✅ Ticket Created Successfully!");
        return true;
      }

      print("❌ Ticket Creation Failed");
      return false;
    } catch (e) {
      print("🔥 Ticket Exception: $e");
      return false;
    }
  }
}
