import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:zanadu/features/login/logic/services/preference_services.dart';

class ZendeskService {
  static const String _baseUrl = "https://api.zanaduhealth.com/api/zendesk";

  /// Upload file to Zendesk
  /// Returns upload token and fileKey on success, null on failure
  static Future<Map<String, dynamic>?> uploadFile(String filePath) async {
    try {
      final file = File(filePath);
      final uri = Uri.parse("$_baseUrl/upload");
      final bytes = await file.readAsBytes();

      // Detect MIME type from file extension and bytes
      final mimeType = lookupMimeType(file.path, headerBytes: bytes) ?? "application/octet-stream";
      final filename = file.path.split('/').last.split('\\').last;

      print("UPLOAD FILE: $filename, MIME: $mimeType");

      final multipartFile = http.MultipartFile.fromBytes(
        "file",
        bytes,
        filename: filename,
        contentType: MediaType.parse(mimeType),
      );

      final request = http.MultipartRequest("POST", uri)
        ..files.add(multipartFile);

      final response = await request.send();
      final body = await response.stream.bytesToString();

      print("UPLOAD STATUS: ${response.statusCode}");
      print("UPLOAD BODY: $body");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(body);
        return data;
      }

      return null;
    } catch (e) {
      print("UPLOAD ERROR: $e");
      return null;
    }
  }

  /// Create a Zendesk ticket
  static Future<Map<String, dynamic>?> createTicket({
    required String category,
    required String description,
    String? uploadToken,
    String? fileKey,
  }) async {
    final userEmail = await Preferences.fetchUserEmail();

    if (userEmail == null || userEmail.isEmpty) {
      print("CREATE TICKET ERROR: User email not found");
      return null;
    }

    try {
      final uri = Uri.parse("$_baseUrl/create-ticket");

      final body = {
        "userEmail": userEmail,
        "category": category,
        "description": description,
        if (uploadToken != null) "uploadToken": uploadToken,
        if (fileKey != null) "fileKey": fileKey,
      };

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("CREATE TICKET STATUS: ${response.statusCode}");
      print("CREATE TICKET RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print("CREATE TICKET ERROR: $e");
      return null;
    }
  }

  /// Fetch tickets for the current user
  static Future<List<dynamic>> fetchTickets() async {
    final userEmail = await Preferences.fetchUserEmail();

    if (userEmail == null || userEmail.isEmpty) {
      print("FETCH TICKETS ERROR: User email not found");
      return [];
    }

    try {
      final uri = Uri.parse("$_baseUrl/tickets?userEmail=$userEmail");

      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      print("FETCH TICKETS STATUS: ${response.statusCode}");
      print("FETCH TICKETS RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          return data;
        } else if (data is Map && data.containsKey("tickets")) {
          return data["tickets"] ?? [];
        } else if (data is Map && data.containsKey("results")) {
          return data["results"] ?? [];
        }
        return [];
      }

      return [];
    } catch (e) {
      print("FETCH TICKETS ERROR: $e");
      return [];
    }
  }
}
