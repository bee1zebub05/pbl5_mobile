import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pbl5_mobile/src/common/utils/logger.dart';
import 'package:pbl5_mobile/src/module/vision_feed/repository/vision_feed_repository.dart';
import 'vision_feed_state.dart';

@injectable
class VisionFeedCubit extends Cubit<VisionFeedState> {
  final VisionFeedRepository repository;

  Timer? _timer;
  bool _isFetching = false;

  VisionFeedCubit(this.repository) : super(const VisionFeedState());

  void start() {
    if (_timer != null) return;

    logger.d('VisionFeedCubit started');

    emit(state.copyWith(isLoading: true));

    _fetch();

    // _timer = Timer.periodic(const Duration(seconds: 3), (_) {
    //   _fetch();
    // });
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
    } catch (e) {
      if (isClosed) return;
      logger.e('fetch at cubit got erorr');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}
