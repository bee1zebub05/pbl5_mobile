import 'package:injectable/injectable.dart';
import 'package:pbl5_mobile/src/module/vision_feed/api/vision_feed_api.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/vision_status.dart';

@injectable
class VisionFeedRepository {
  final VisionFeedApi api;

  VisionFeedRepository(this.api);

  /// Lấy dữ liệu GPS + device
  Future<VisionStatus> getStatus() async {
    final json = await api.fetchStatus();

    return VisionStatus.fromJson(json);
  }

  /// Lấy URL stream
  String getStreamUrl() {
    return api.getStreamUrl();
  }
}