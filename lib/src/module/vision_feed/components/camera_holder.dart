import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl5_mobile/src/module/vision_feed/cubit/vision_feed_cubit.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';

class CameraHolder extends StatelessWidget {
  const CameraHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VisionFeedCubit>();
    final streamUrl = cubit.repository.getStreamUrl();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.horizontalPadding,
        AppSizes.horizontalPadding,
        AppSizes.horizontalPadding,
        0,
      ),
      child: Container(
        height: AppSizes.cameraHolderHeight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          streamUrl,
          fit: BoxFit.cover,
          gaplessPlayback: true, // tránh nháy frame
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.error, color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}