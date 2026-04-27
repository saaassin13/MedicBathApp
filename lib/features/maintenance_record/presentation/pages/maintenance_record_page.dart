import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/maintenance_record_provider.dart';
import '../../domain/entities.dart';

/// 维保记录页面
class MaintenanceRecordPage extends ConsumerWidget {
  const MaintenanceRecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(maintenanceRecordsProvider);
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
      body: recordsAsync.when(
        data: (records) => _buildRecordList(records),
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

  Widget _buildRecordList(List<MaintenanceRecordItem> records) {
    if (records.isEmpty) {
      return const Center(child: Text('暂无维保记录'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题：图标 + 维保记录查询
              const Row(
                children: [
                  Icon(Icons.history, size: 20, color: AppColors.primaryOrange),
                  SizedBox(width: 8),
                  Text(
                    '维保记录查询',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              // 维保记录列表
              ...records.map((record) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${record.timestamp} 完成 ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextSpan(
                            text: record.taskName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const TextSpan(
                            text: ' 维保任务',
                            style: TextStyle(
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
}
