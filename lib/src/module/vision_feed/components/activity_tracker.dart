import 'package:flutter/material.dart';
import 'package:pbl5_mobile/src/module/vision_feed/constant/app_colors.dart';

class ActivityTrackerCard extends StatelessWidget {
  const ActivityTrackerCard({super.key, 
    required this.wearer,
    required this.stats,
  });

  final WearerInfo wearer;
  final List<StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.horizontalPadding,
        AppSizes.sectionSpacing,
        AppSizes.horizontalPadding,
        0,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _WearerHeader(wearer: wearer),
            const SizedBox(height: AppSizes.gapL),
            _StatsRow(stats: stats),
          ],
        ),
      ),
    );
  }
}

class WearerInfo {
  final String name;
  final String location;

  const WearerInfo({
    required this.name,
    required this.location,
  });
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
        _InfoLabel(
          label: 'ACTIVE WEARER',
          value: wearer.name,
          textAlign: TextAlign.left,
          valueStyle: AppTextStyles.wearerName,
        ),
        _InfoLabel(
          label: 'LOCATION',
          value: wearer.location,
          textAlign: TextAlign.right,
          valueStyle: AppTextStyles.locationName,
        ),
      ],
    );
  }
}

class _InfoLabel extends StatelessWidget {
  const _InfoLabel({
    required this.label,
    required this.value,
    required this.textAlign,
    required this.valueStyle,
  });

  final String label;
  final String value;
  final TextAlign textAlign;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
        const SizedBox(height: AppSizes.gapXS),
        Text(value, textAlign: textAlign, style: valueStyle),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});

  final List<StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < stats.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSizes.gapM),
          Expanded(child: _StatCard(item: stats[i])),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});

  final StatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.statCardPadding),
      height: AppSizes.statCardHeight,
      decoration: BoxDecoration(
        color: AppColors.statCardBackground,
        borderRadius: BorderRadius.circular(AppSizes.statCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.iconColor, size: AppSizes.statIconSize),
          const SizedBox(height: AppSizes.gapS),
          Text(item.value, style: AppTextStyles.statValue),
          const SizedBox(height: AppSizes.gapXS),
          Text(item.label, style: AppTextStyles.statLabel),
        ],
      ),
    );
  }
}