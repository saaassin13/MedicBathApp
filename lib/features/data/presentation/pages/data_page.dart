import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/data_provider.dart';
import '../widgets/chart_card.dart';
import '../widgets/usage_chart_card.dart';

/// 数据分析页面
class DataPage extends ConsumerWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(dataPageDataProvider);
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
      body: dataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dataPageDataProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                // 近7天作业数据分析
                ChartCard(
                  title: '近7天作业数据分析',
                  dates: data.chartData.dates,
                  cowCounts: data.chartData.cowCounts,
                  recognitionRates: data.chartData.recognitionRates,
                ),

                const SizedBox(height: 12),

                // 近7天药液用量分析
                UsageChartCard(
                  title: '近7天药液用量分析',
                  totalUsage: data.usageStats.totalUsage,
                  avgUsage: data.usageStats.avgUsage,
                  maxDailyUsage: data.usageStats.maxDailyUsage,
                  maxDailyDate: data.usageStats.maxDailyDate,
                ),

                const SizedBox(height: 12),

                // 覆盖情况分析
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.pie_chart, size: 18, color: AppColors.primaryOrange),
                            SizedBox(width: 6),
                            Text(
                              '近7天覆盖情况分析',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...data.coverageStats.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.type,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${item.count}',
                                        style: const TextStyle(
                                          color: AppColors.primaryOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Text(
                                        '头',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        ' (${item.percentage}%)',
                                        style: const TextStyle(
                                          color: AppColors.primaryOrange,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
