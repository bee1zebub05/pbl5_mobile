import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class VisionFeedApi {
  static const String baseUrl = 'https://pbl5.lexastudy.id.vn';

  /// Lấy GPS + trạng thái
  Future<Map<String, dynamic>> fetchStatus() async {
    final res = await http.get(Uri.parse('$baseUrl/status'));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch status');
    }

    return jsonDecode(res.body);
  }

  Future<String?> reverseGeocode({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
      'format': 'jsonv2',
      'lat': lat.toStringAsFixed(6),
      'lon': lon.toStringAsFixed(6),
      'accept-language': 'vi,en',
    });

    final res = await http.get(
      uri,
      headers: {
        'User-Agent': 'pbl5_mobile/1.0 (vision feed reverse geocoding)',
      },
    );

    if (res.statusCode != 200) {
      return null;
    }

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final displayName = (body['display_name'] as String?)?.trim();
    if (displayName == null || displayName.isEmpty) {
      return null;
    }

    return displayName;
  }

  /// URL stream (dùng trực tiếp cho Image widget)
  String getStreamUrl() {
    return '$baseUrl/stream';
  }
}