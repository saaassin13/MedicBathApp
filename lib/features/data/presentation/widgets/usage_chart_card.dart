import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 药液用量卡片组件 - 仅统计数据
class UsageChartCard extends StatelessWidget {
  final String title;
  final double totalUsage;
  final double avgUsage;
  final double maxDailyUsage;
  final String maxDailyDate;

  const UsageChartCard({
    super.key,
    required this.title,
    required this.totalUsage,
    required this.avgUsage,
    required this.maxDailyUsage,
    required this.maxDailyDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.water_drop, size: 18, color: AppColors.primaryOrange),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '总用量',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  totalUsage.toStringAsFixed(0),
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  ' L',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '日均用量',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  avgUsage.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  ' ML',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '最大日用量日期（$maxDailyDate）',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  maxDailyUsage.toStringAsFixed(2),
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  ' ML',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
