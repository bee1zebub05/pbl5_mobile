import 'package:injectable/injectable.dart';
import 'package:pbl5_mobile/src/common/utils/logger.dart';
import 'package:pbl5_mobile/src/module/vision_feed/api/vision_feed_api.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/vision_status.dart';

@injectable
class VisionFeedRepository {
  final VisionFeedApi api;

  VisionFeedRepository(this.api);

  /// Lấy dữ liệu GPS + device
  Future<VisionStatus> getStatus() async {
    logger.d('trying get status at repository');
    final json = await api.fetchStatus();

    return VisionStatus.fromJson(json);
  }

  Future<String?> getAddressFromLatLon({
    required double lat,
    required double lon,
  }) async {
    return api.reverseGeocode(lat: lat, lon: lon);
  }

  /// Lấy URL stream
  String getStreamUrl() {
    logger.d('trying get stream url at repository');
    return api.getStreamUrl();
  }
}