import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/kpi_card.dart';
import '../widgets/monitor_card.dart';
import '../widgets/status_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeDataAsync = ref.watch(homePageDataProvider);
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
      body: homeDataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(homePageDataProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                // 报警条
                if (data.alarm.hasAlarm)
                  Card(
                    color: AppColors.errorRed,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data.alarm.description ?? '设备异常',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: AppColors.successGreen),
                          SizedBox(width: 8),
                          Text(
                            '无异常报警',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // KPI 卡片
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        icon: Icons.pets,
                        title: '识别牛数',
                        value: data.kpi.cowCount.toString(),
                        unit: '头',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: KpiCard(
                        icon: Icons.analytics,
                        title: '乳头识别率',
                        value: data.kpi.recognitionRate.toString(),
                        unit: '%',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: KpiCard(
                        icon: Icons.water_drop,
                        title: '药液用量',
                        value: data.kpi.totalUsage.toString(),
                        unit: 'L',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: KpiCard(
                        icon: Icons.opacity,
                        title: '药液均量',
                        value: data.kpi.avgUsage.toString(),
                        unit: 'ML',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 监控卡片（合并为一个卡片，包含多个监控画面）
                MonitorCard(
                  overallStatus: data.monitors.isNotEmpty && data.monitors.first.status == 'normal'
                      ? '运行中'
                      : '运行异常',
                  monitors: [
                    const MonitorItem(status: '运行中', cameraType: '监控视角'),
                    const MonitorItem(status: '运行异常', cameraType: '作业视角'),
                  ],
                ),

                const SizedBox(height: 12),

                // 状态卡片
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: StatusCard(
                          title: '设备状态',
                          icon: Icons.build,
                          items: data.deviceStatus
                              .map((d) => (name: d.name, status: d.status))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatusCard(
                          title: '维保状态',
                          icon: Icons.engineering,
                          items: data.maintenanceStatus
                              .map((d) => (name: d.name, status: d.status))
                              .toList(),
                        ),
                      ),
                    ],
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
