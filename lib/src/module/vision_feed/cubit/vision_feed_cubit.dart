import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pbl5_mobile/src/module/vision_feed/repository/vision_feed_repository.dart';
import 'vision_feed_state.dart';

@injectable
class VisionFeedCubit extends Cubit<VisionFeedState> {
  final VisionFeedRepository repository;

  Timer? _timer;

  VisionFeedCubit(this.repository) : super(const VisionFeedState());

  /// Start polling realtime
  void start() {
    emit(state.copyWith(isLoading: true));

    _fetch(); // fetch lần đầu

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _fetch();
    });
  }

  /// Stop polling (important)
  void stop() {
    _timer?.cancel();
  }

  Future<void> _fetch() async {
    try {
      final status = await repository.getStatus();

      emit(state.copyWith(
        isLoading: false,
        status: status,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}