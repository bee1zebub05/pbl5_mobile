import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/constant/ui_constant.dart';
import 'package:pbl5_mobile/src/common/utils/getit_utils.dart';
import 'package:pbl5_mobile/src/common/widgets/text/heading_text.dart';
import 'package:pbl5_mobile/src/common/widgets/text/paragrahp_text.dart';
import 'package:pbl5_mobile/src/module/vision_feed/repository/vision_feed_repository.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  final VisionFeedRepository _repository = getIt<VisionFeedRepository>();
  final MapController _mapController = MapController();
  Timer? _timer;

  String _currentAddress = 'Loading current address...';
  double? _lat;
  double? _lon;
  double? _ageSeconds;

  double? _lastGeocodedLat;
  double? _lastGeocodedLon;
  bool _isReverseGeocoding = false;

  static const LatLng _defaultCenter = LatLng(16.035515, 108.188896);

  @override
  void initState() {
    super.initState();
    _refreshStatus();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      _refreshStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _refreshStatus() async {
    try {
      final status = await _repository.getStatus();
      final gps = status.gps;

      if (!mounted) return;

      setState(() {
        _ageSeconds = status.age;
        _lat = gps?.lat;
        _lon = gps?.lon;
      });

      _moveMapToCurrentPosition();

      if (_lat == null || _lon == null) {
        if (!mounted) return;
        setState(() {
          _currentAddress = 'No GPS fix';
        });
        return;
      }

      final hasMoved = _lastGeocodedLat == null ||
          _lastGeocodedLon == null ||
          (_lat! - _lastGeocodedLat!).abs() > 0.0001 ||
          (_lon! - _lastGeocodedLon!).abs() > 0.0001;

      if (hasMoved) {
        await _reverseGeocode(_lat!, _lon!);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _currentAddress = 'Unable to load server location';
      });
    }
  }

  void _moveMapToCurrentPosition() {
    if (_lat == null || _lon == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _mapController.move(LatLng(_lat!, _lon!), 17);
    });
  }

  Future<void> _reverseGeocode(double lat, double lon) async {
    if (_isReverseGeocoding) return;
    _isReverseGeocoding = true;

    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
        'format': 'jsonv2',
        'lat': lat.toStringAsFixed(6),
        'lon': lon.toStringAsFixed(6),
        'accept-language': 'vi,en',
      });

      final res = await http.get(
        uri,
        headers: {
          'User-Agent': 'pbl5_mobile/1.0 (tracker reverse geocoding)'
        },
      );

      if (res.statusCode != 200) return;

      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final displayName = (json['display_name'] as String?)?.trim();
      if (displayName == null || displayName.isEmpty) return;

      if (!mounted) return;
      setState(() {
        _currentAddress = displayName;
        _lastGeocodedLat = lat;
        _lastGeocodedLon = lon;
      });
    } catch (_) {
      // Keep the last known address on reverse geocoding errors.
    } finally {
      _isReverseGeocoding = false;
    }
  }

  String _ageText() {
    if (_ageSeconds == null) return '-';
    return '${_ageSeconds!.toStringAsFixed(1)}s ago';
  }

  LatLng _mapCenter() {
    if (_lat == null || _lon == null) return _defaultCenter;
    return LatLng(_lat!, _lon!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.account_circle_outlined,
            size: 36.h,
            color: ColorName.primary,
          ),
          actions: [
            Icon(Icons.settings_outlined, size: 36.h, color: ColorName.gray),
          ],
          centerTitle: true,
          title: HeadingText(text: 'Tracker'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox.expand(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _mapCenter(),
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.pbl5_mobile',
                  ),
                  if (_lat != null && _lon != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 44,
                          height: 44,
                          point: LatLng(_lat!, _lon!),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIConst.paddingHorizontal/4,
                  vertical: UIConst.paddingVertical
                ),
                width: 342.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(30.sp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: ParagraphText(
                              text: 'CURRENT ADDRESS',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2.w,
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentAddress,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorName.black,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    (_lat != null && _lon != null)
                                        ? 'Lat/Lon: ${_lat!.toStringAsFixed(6)}, ${_lon!.toStringAsFixed(6)}'
                                        : 'Lat/Lon: -',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorName.muted,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.timer),
                        SizedBox(width: 10.w),
                        ParagraphText(text: _ageText()),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
