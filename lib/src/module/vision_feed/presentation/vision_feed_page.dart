import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5_mobile/src/common/utils/getit_utils.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/activity_tracker.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/camera_holder.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/info_bar.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';
import 'package:pbl5_mobile/src/module/vision_feed/cubit/vision_feed_cubit.dart';

class VisionFeedPage extends StatelessWidget {
  const VisionFeedPage({super.key});

  static const wearer = WearerInfo(
    name: 'Thanh Cat\nTu Han',
    location: 'Kinh Chau\nTrung Quoc',
  );

  static const stats = [
    StatItem(
      icon: Icons.directions_walk,
      iconColor: AppColors.walkIconColor,
      value: '1.2 km',
      label: 'Travel Distance',
    ),
    StatItem(
      icon: Icons.timelapse,
      iconColor: AppColors.paceIconColor,
      value: '4.2 km/h',
      label: 'Current Pace',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VisionFeedCubit>()..start(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InfoBar(),
                CameraHolder(),
                ActivityTrackerCard(wearer: wearer, stats: stats),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
