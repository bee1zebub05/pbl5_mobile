import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF1E3A8A);
  static const icon = Color(0xFF64748B);
  static const background = Colors.white;
  static const cardBackground = Color(0xFFF3F4F5);
  static const statCardBackground = Colors.white;
  static const titleText = Color(0xFF191C1D);
  static const bodyText = Color(0xFF424750);
  static const labelText = Color(0xFF6E7279);
  static const walkIconColor = Color(0xFF003461);
  static const paceIconColor = Color(0xFF793701);
}

abstract class AppSizes {
  // Padding / spacing
  static const double pagePaddingH = 24.0;
  static const double pagePaddingV = 10.0;
  static const double infoBarHeight = 64.0;
  static const double sectionSpacing = 32.0;
  static const double cardPadding = 20.0;
  static const double statCardPadding = 16.0;
  static const double statCardHeight = 120.0;
  static const double cameraHolderHeight = 480.0;
  static const double horizontalPadding = 16.0;

  // Border radius
  static const double cardRadius = 30.0;
  static const double statCardRadius = 18.0;

  // Icons
  static const double topBarIconSize = 36.0;
  static const double statIconSize = 26.0;

  // Gaps
  static const double gapXS = 4.0;
  static const double gapS = 10.0;
  static const double gapM = 12.0;
  static const double gapL = 20.0;
}

abstract class AppTextStyles {
  static const appBarTitle = TextStyle(
    fontSize: 30,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  static const sectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.labelText,
    letterSpacing: 3.2,
  );

  static const wearerName = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.titleText,
    height: 1.2,
  );

  static const locationName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.titleText,
    height: 1.3,
  );

  static const statValue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A1A),
    height: 1.2,
  );

  static const statLabel = TextStyle(
    fontSize: 13,
    color: AppColors.bodyText,
    fontWeight: FontWeight.w500,
  );
}
