import 'package:equatable/equatable.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/vision_status.dart';

class VisionFeedState extends Equatable {
  final bool isLoading;
  final VisionStatus? status;
  final String? error;
  final String location;

  const VisionFeedState({
    this.isLoading = false,
    this.status,
    this.error,
    this.location = 'Loading location...',
  });

  VisionFeedState copyWith({
    bool? isLoading,
    VisionStatus? status,
    String? error,
    String? location,
  }) {
    return VisionFeedState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      error: error,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [isLoading, status, error, location];
}