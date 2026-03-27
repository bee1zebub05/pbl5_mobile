import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pbl5_mobile/src/common/utils/logger.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/vision_status.dart';
import 'package:pbl5_mobile/src/module/vision_feed/repository/vision_feed_repository.dart';
import 'vision_feed_state.dart';

@injectable
class VisionFeedCubit extends Cubit<VisionFeedState> {
  final VisionFeedRepository repository;

  Timer? _timer;
  bool _isFetching = false;
  bool _isResolvingLocation = false;
  double? _lastGeocodedLat;
  double? _lastGeocodedLon;

  VisionFeedCubit(this.repository) : super(const VisionFeedState());

  void start() {
    if (_timer != null) return;

    logger.d('VisionFeedCubit started');

    emit(state.copyWith(isLoading: true));

    _fetch();

    // Keep status in sync with server like the web client polling loop.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _fetch();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    logger.d('VisionFeedCubit stopped');
  }

  Future<void> _fetch() async {
    logger.d('fetch at Cubit called');

    if (_isFetching) return;
    _isFetching = true;

    try {
      final status = await repository.getStatus();

      if (isClosed) return;

      emit(state.copyWith(isLoading: false, status: status, error: null));
      await _updateLocation(status);
    } catch (e) {
      if (isClosed) return;
      logger.e('fetch at cubit got erorr');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _updateLocation(VisionStatus status) async {
    final gps = status.gps;
    final lat = gps?.lat;
    final lon = gps?.lon;

    if (lat == null || lon == null) {
      if (!isClosed) {
        emit(state.copyWith(location: 'No GPS fix'));
      }
      return;
    }

    final moved = _lastGeocodedLat == null ||
        _lastGeocodedLon == null ||
        (lat - _lastGeocodedLat!).abs() > 0.0001 ||
        (lon - _lastGeocodedLon!).abs() > 0.0001;

    if (!moved || _isResolvingLocation) return;

    _isResolvingLocation = true;
    try {
      final address = await repository.getAddressFromLatLon(lat: lat, lon: lon);
      if (isClosed || address == null || address.isEmpty) return;

      _lastGeocodedLat = lat;
      _lastGeocodedLon = lon;
      emit(state.copyWith(location: address));
    } catch (_) {
      // Keep last known location when reverse geocoding fails.
    } finally {
      _isResolvingLocation = false;
    }
  }

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}
