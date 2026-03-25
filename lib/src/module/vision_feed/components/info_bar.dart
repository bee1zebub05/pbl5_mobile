import 'package:flutter/material.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';

class InfoBar extends StatelessWidget {
  const InfoBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.infoBarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingH,
          vertical: AppSizes.pagePaddingV,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.account_circle_outlined,
              size: AppSizes.topBarIconSize,
              color: AppColors.primary,
            ),
            Text('Vision Feed', style: AppTextStyles.appBarTitle),
            Icon(
              Icons.settings_outlined,
              size: AppSizes.topBarIconSize,
              color: AppColors.icon,
            ),
          ],
        ),
      ),
    );
  }
}
