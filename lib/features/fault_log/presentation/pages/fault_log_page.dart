import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/fault_log_provider.dart';
import '../../domain/entities.dart';

/// 故障日志页面
class FaultLogPage extends ConsumerWidget {
  const FaultLogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faultLogsAsync = ref.watch(faultLogsProvider);
    final farmDisplayName = ref.watch(currentFarmDisplayNameProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryOrange,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: GestureDetector(
          onTap: () => _showFarmSelector(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                farmDisplayName,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const Icon(Icons.arrow_drop_down, size: 20, color: Colors.white),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => context.go('/personal-center'),
          ),
        ],
      ),
      body: faultLogsAsync.when(
        data: (logs) => _buildLogList(logs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('加载失败: $error'),
        ),
      ),
    );
  }

  /// 显示奶厅选择页面
  void _showFarmSelector(BuildContext context) {
    GoRouter.of(context).push('/select-farm');
  }

  Widget _buildLogList(List<FaultLogItem> logs) {
    if (logs.isEmpty) {
      return const Center(child: Text('暂无故障日志'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题：图标 + 故障日志查询
              const Row(
                children: [
                  Icon(Icons.warning_amber, size: 20, color: AppColors.primaryOrange),
                  SizedBox(width: 8),
                  Text(
                    '故障日志查询',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              // 日志列表
              ...logs.map((log) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${log.timestamp} ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextSpan(
                            text: '[${log.levelLabel}]',
                            style: TextStyle(
                              fontSize: 14,
                              color: _getLevelColor(log.level),
                            ),
                          ),
                          TextSpan(
                            text: ' ${log.description}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              // 分割线
              const Divider(height: 24),
              // 加载更多（居中）
              const Center(
                child: Text(
                  '加载更多...',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(FaultLevel level) {
    switch (level) {
      case FaultLevel.error:
        return const Color(0xFFE53935); // 红色
      case FaultLevel.warning:
        return const Color(0xFFFF9800); // 橙色
      case FaultLevel.info:
        return const Color(0xFF4CAF50); // 绿色
    }
  }

  }
