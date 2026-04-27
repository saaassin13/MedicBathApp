import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 状态类型
enum StatusType { normal, warning, error }

/// 状态标签
/// 根据 status 显示不同颜色圆点
class StatusTag extends StatelessWidget {
  final String label;
  final StatusType status;

  const StatusTag({
    super.key,
    required this.label,
    required this.status,
  });

  Color get _dotColor {
    switch (status) {
      case StatusType.normal:
        return AppColors.successGreen;
      case StatusType.warning:
        return AppColors.warningOrange;
      case StatusType.error:
        return AppColors.errorRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}