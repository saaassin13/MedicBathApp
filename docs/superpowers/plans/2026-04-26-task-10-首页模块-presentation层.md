# Task 10: 首页模块 - Presentation 层

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建首页模块的 Presentation 层，包含首页页面和状态管理

**Architecture:** 首页模块 presentation 层

**Tech Stack:** Riverpod, HomePage, KPI Cards, Monitor Cards, Status Cards

---

## Files

- Create: `lib/features/home/presentation/pages/home_page.dart`
- Create: `lib/features/home/presentation/providers/home_provider.dart`
- Create: `lib/features/home/presentation/widgets/kpi_card.dart`
- Create: `lib/features/home/presentation/widgets/monitor_card.dart`
- Create: `lib/features/home/presentation/widgets/status_card.dart`

---

## Step by Step

- [x] **Step 1: 创建 home_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/home_repository.dart';
import '../../domain/home_page_data.dart';
import '../../data/mock_home_repository.dart';

/// Home Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return MockHomeRepository();
});

/// 首页数据 Provider
final homePageDataProvider = FutureProvider<HomePageData>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getHomePageData();
});
```

- [x] **Step 2: 创建 kpi_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class KpiCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;

  const KpiCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
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
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(icon, color: AppColors.primaryOrange, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    unit,
                    style: const TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 12,
                    ),
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
```

- [x] **Step 3: 创建 monitor_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MonitorCard extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback? onTap;

  const MonitorCard({
    super.key,
    required this.title,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (status == '运行中')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.successGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '运行正常',
                            style: TextStyle(
                              color: AppColors.successGreen,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: const Center(
                child: Icon(Icons.videocam, size: 48, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [x] **Step 4: 创建 status_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_tag.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final List<({String name, String status})> items;

  const StatusCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map((item) {
              final statusType = item.status == 'normal'
                  ? StatusType.normal
                  : item.status == 'warning'
                      ? StatusType.warning
                      : StatusType.error;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: StatusTag(label: item.name, status: statusType),
              );
            }),
          ],
        ),
      ),
    );
  }
}
```

- [x] **Step 5: 创建 home_page.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/kpi_card.dart';
import '../widgets/monitor_card.dart';
import '../widgets/status_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeDataAsync = ref.watch(homePageDataProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: const Text('双城牧场-一期奶厅-一号转盘'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: () {
              // TODO: 显示奶厅选择
            },
          ),
        ],
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
                    color: AppColors.successGreen,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '无异常报警',
                            style: TextStyle(color: Colors.white),
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

                // 监控卡片
                ...data.monitors.map((monitor) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: MonitorCard(
                        title: monitor.type,
                        status: monitor.status,
                      ),
                    )),

                const SizedBox(height: 12),

                // 状态卡片
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StatusCard(
                        title: '设备状态',
                        items: data.deviceStatus
                            .map((d) => (name: d.name, status: d.status))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatusCard(
                        title: '维保状态',
                        items: data.maintenanceStatus
                            .map((d) => (name: d.name, status: d.status))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

---

## Verification

- [ ] 首页显示报警条（正常/异常两种状态）
- [ ] 4 个 KPI 卡片显示正确数值
- [ ] 2 个监控卡片显示监控视图
- [ ] 设备状态和维保状态垂直排列标签