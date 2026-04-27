import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 加载卡片
/// 显示加载中状态
class LoadingCard extends StatelessWidget {
  final String? message;

  const LoadingCard({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primaryOrange,
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}