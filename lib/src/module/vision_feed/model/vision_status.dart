class VisionStatus {
  final String? device;
  final double? age;
  final GPSData? gps;

  VisionStatus({
    this.device,
    this.age,
    this.gps,
  });

  factory VisionStatus.fromJson(Map<String, dynamic> json) {
    return VisionStatus(
      device: json['device'],
      age: (json['age_s'] as num?)?.toDouble(),
      gps: json['gps'] != null ? GPSData.fromJson(json['gps']) : null,
    );
  }
}

class GPSData {
  final bool gpsOk;
  final double? lat;
  final double? lon;
  final double? speed;
  final double? alt;
  final int? vsat;
  final int? usat;
  final double? acc;
  final String? gpsTime;

  GPSData({
    required this.gpsOk,
    this.lat,
    this.lon,
    this.speed,
    this.alt,
    this.vsat,
    this.usat,
    this.acc,
    this.gpsTime,
  });

  factory GPSData.fromJson(Map<String, dynamic> json) {
    return GPSData(
      gpsOk: json['gps_ok'] ?? false,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      alt: (json['alt'] as num?)?.toDouble(),
      vsat: json['vsat'],
      usat: json['usat'],
      acc: (json['acc'] as num?)?.toDouble(),
      gpsTime: json['gps_time'],
    );
  }
}