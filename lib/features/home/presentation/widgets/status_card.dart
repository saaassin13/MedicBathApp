import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final List<({String name, String status})> items;
  final IconData? icon; // 可选图标

  const StatusCard({
    super.key,
    required this.title,
    required this.items,
    this.icon,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'normal':
        return AppColors.successGreen;
      case 'warning':
        return AppColors.warningOrange;
      case 'error':
        return AppColors.errorRed;
      default:
        return AppColors.successGreen;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'normal':
        return '正常';
      case 'warning':
        return '警告';
      case 'error':
        return '异常';
      default:
        return '正常';
    }
  }

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
                if (icon != null) ...[
                  Icon(icon, color: AppColors.primaryOrange, size: 16),
                  const SizedBox(width: 6),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) {
              final statusColor = _getStatusColor(item.status);
              final statusText = _getStatusText(item.status);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
