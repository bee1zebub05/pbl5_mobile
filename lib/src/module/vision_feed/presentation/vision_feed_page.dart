import 'package:flutter/material.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/activity_tracker.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/camera_holder.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/info_bar.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';

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
    return Scaffold(
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
    );
  }
}
