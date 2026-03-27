import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/constant/ui_constant.dart';
import 'package:pbl5_mobile/src/common/widgets/text/paragrahp_text.dart';

class ActivityTrackerCard extends StatelessWidget {
  const ActivityTrackerCard({
    super.key,
    required this.wearer,
    required this.stats,
  });

  final WearerInfo wearer;
  final List<StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        UIConst.paddingHorizontal,
        UIConst.paddingVertical,
        UIConst.paddingHorizontal,
        0,
      ),
      child: Container(
        padding: const EdgeInsets.all(UIConst.paddingDefault),
        decoration: BoxDecoration(
          color: ColorName.gray,
          borderRadius: BorderRadius.circular(UIConst.radiusDefault),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _WearerHeader(wearer: wearer),
            //const SizedBox(height: UIConst.paddingDefault),
            //_StatsRow(stats: stats),
          ],
        ),
      ),
    );
  }
}

class WearerInfo {
  final String name;
  final String location;

  const WearerInfo({required this.name, required this.location});
}

class StatItem {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });
}

class _WearerHeader extends StatelessWidget {
  const _WearerHeader({required this.wearer});

  final WearerInfo wearer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ParagraphText(
              text: 'ACTIVE WEARER',
              color: ColorName.lightBlack,
              letterSpacing: 1.2.w,
            ),
            ParagraphText(
              text: wearer.name,
              color: ColorName.black,
              fontWeight: FontWeight.bold,
              size: 24.sp,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ParagraphText(
              text: 'LOCATION',
              color: ColorName.black,
              letterSpacing: 1.2.w,
            ),
            ParagraphText(
              text: wearer.location,
              color: ColorName.black,
              fontWeight: FontWeight.bold,
              size: 24.sp,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }
}
