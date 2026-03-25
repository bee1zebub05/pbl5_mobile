import 'package:flutter/material.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';

class CameraHolder extends StatelessWidget {
  const CameraHolder({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
