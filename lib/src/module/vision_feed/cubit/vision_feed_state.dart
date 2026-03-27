import 'package:equatable/equatable.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/vision_status.dart';

class VisionFeedState extends Equatable {
  final bool isLoading;
  final VisionStatus? status;
  final String? error;

  const VisionFeedState({
    this.isLoading = false,
    this.status,
    this.error,
  });

  VisionFeedState copyWith({
    bool? isLoading,
    VisionStatus? status,
    String? error,
  }) {
    return VisionFeedState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, status, error];
}