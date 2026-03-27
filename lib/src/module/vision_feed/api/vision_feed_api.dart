import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class VisionFeedApi {
  static const String baseUrl = 'http://192.168.1.10:3000';

  /// Lấy GPS + trạng thái
  Future<Map<String, dynamic>> fetchStatus() async {
    final res = await http.get(Uri.parse('$baseUrl/status'));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch status');
    }

    return jsonDecode(res.body);
  }

  /// URL stream (dùng trực tiếp cho Image widget)
  String getStreamUrl() {
    return '$baseUrl/stream';
  }
}