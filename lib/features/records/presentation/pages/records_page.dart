import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../data/domain/chart_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/records_provider.dart';
import '../../domain/entities.dart';

/// 记录页面
class RecordsPage extends ConsumerWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(recordsProvider);
    final farmDisplayName = ref.watch(currentFarmDisplayNameProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _showFarmSelector(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                farmDisplayName,
                style: const TextStyle(fontSize: 14),
              ),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: recordsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
        data: (dateGroups) {
          if (dateGroups.isEmpty) {
            return const Center(child: Text('暂无记录'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dateGroups.length,
            itemBuilder: (context, index) {
              final dateGroup = dateGroups[index];
              return _DateGroupCard(dateGroup: dateGroup);
            },
          );
        },
      ),
    );
  }

  /// 显示奶厅选择页面
  void _showFarmSelector(BuildContext context) {
    GoRouter.of(context).push('/select-farm');
  }
}

/// 日期分组卡片
class _DateGroupCard extends StatelessWidget {
  final DateGroup dateGroup;

  const _DateGroupCard({required this.dateGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              dateGroup.dateLabel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        ...dateGroup.items.map((item) => _RecordItemCard(item: item)),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// 记录项卡片
class _RecordItemCard extends StatelessWidget {
  final RecordItem item;

  const _RecordItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间区间和运行时长同一行
            Row(
              children: [
                Text(
                  '${item.startTime} - ${item.endTime}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '运行: ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  item.formattedDuration,
                  style: TextStyle(
                    fontSize: 14,
                    color: ChartColors.chartBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 三栏指标同一行
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: '药浴：', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      TextSpan(text: '${item.cowCount} ', style: const TextStyle(fontSize: 14, color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                      const TextSpan(text: '头', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: '识别率：', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      TextSpan(text: '${item.recognitionRate} ', style: const TextStyle(fontSize: 14, color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                      const TextSpan(text: '%', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: '均量：', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      TextSpan(text: '${item.avgUsage} ', style: const TextStyle(fontSize: 14, color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                      const TextSpan(text: 'ML', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}