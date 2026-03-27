// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pbl5_mobile/src/common/utils/logger.dart' as _i944;
import 'package:pbl5_mobile/src/module/vision_feed/api/vision_feed_api.dart'
    as _i434;
import 'package:pbl5_mobile/src/module/vision_feed/cubit/vision_feed_cubit.dart'
    as _i350;
import 'package:pbl5_mobile/src/module/vision_feed/repository/vision_feed_repository.dart'
    as _i216;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final loggerModule = _$LoggerModule();
    gh.singleton<_i207.Talker>(() => loggerModule.talker());
    gh.singleton<_i434.VisionFeedApi>(() => _i434.VisionFeedApi());
    gh.factory<_i216.VisionFeedRepository>(
      () => _i216.VisionFeedRepository(gh<_i434.VisionFeedApi>()),
    );
    gh.factory<_i350.VisionFeedCubit>(
      () => _i350.VisionFeedCubit(gh<_i216.VisionFeedRepository>()),
    );
    return this;
  }
}

class _$LoggerModule extends _i944.LoggerModule {}
