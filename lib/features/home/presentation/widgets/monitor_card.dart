import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 监控画面数据模型
class MonitorItem {
  final String status; // "运行中" / "运行异常"
  final String cameraType; // "监控视角" / "作业视角"

  const MonitorItem({
    required this.status,
    required this.cameraType,
  });
}

/// 监控卡片
class MonitorCard extends StatelessWidget {
  final String overallStatus; // 整体状态
  final List<MonitorItem> monitors; // 监控画面列表

  const MonitorCard({
    super.key,
    required this.overallStatus,
    required this.monitors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题区
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.visibility, color: AppColors.primaryOrange, size: 20),
                const SizedBox(width: 8),
                const Text(
                  '实时监控',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // 监控画面列表
          ...monitors.map((monitor) => _MonitorView(item: monitor)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

/// 单个监控画面组件
class _MonitorView extends StatelessWidget {
  final MonitorItem item;

  const _MonitorView({required this.item});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final monitorHeight = screenHeight * 0.16; // 屏幕高度的 16%
    final isNormal = item.status == '运行中';

    return Container(
      height: monitorHeight,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // 监控画面占位符（实际项目会替换为视频组件）
          Center(
            child: Icon(Icons.videocam, size: screenHeight * 0.04, color: Colors.grey[400]),
          ),
          // 左上：状态（灰底）
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isNormal ? AppColors.successGreen : AppColors.errorRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.status,
                    style: TextStyle(fontSize: screenHeight * 0.012, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          // 右上：放大缩小图标
          Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.fullscreen, size: screenHeight * 0.022, color: Colors.grey[600]),
          ),
          // 右下：视角标签（红底）
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.errorRed,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.cameraType,
                style: TextStyle(fontSize: screenHeight * 0.012, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
