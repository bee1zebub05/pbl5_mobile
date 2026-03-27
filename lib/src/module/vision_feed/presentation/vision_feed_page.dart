import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/utils/getit_utils.dart';
import 'package:pbl5_mobile/src/common/widgets/text/heading_text.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/activity_tracker.dart';
import 'package:pbl5_mobile/src/module/vision_feed/components/camera_holder.dart';
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
      iconColor: ColorName.secondary,
      value: '1.2 km',
      label: 'Travel Distance',
    ),
    StatItem(
      icon: Icons.timelapse,
      iconColor: ColorName.secondary,
      value: '4.2 km/h',
      label: 'Current Pace',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<VisionFeedCubit>()..start(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.account_circle_outlined,
            size: 36.h,
            color: ColorName.primary,
          ),
          actions: [
            Icon(
              Icons.settings_outlined,
              size: 36.h,
              color: ColorName.gray,
            )
          ],
          centerTitle: true,
          title: HeadingText(text: 'Vision Feed'),
        ),
        
        backgroundColor: ColorName.neutral,
        
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
