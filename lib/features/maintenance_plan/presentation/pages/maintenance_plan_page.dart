import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/maintenance_plan_provider.dart';

/// 维保计划页面，展示设备维保项目按剩余时间升序排列
class MaintenancePlanPage extends ConsumerWidget {
  const MaintenancePlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(maintenancePlansProvider);
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
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
        data: (plans) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: plans.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // 页面标题
              return const Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(
                  '维保计划',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }
            final plan = plans[index - 1];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 第一行：维保内容 + 维保周期
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            plan.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '维保周期：${plan.cycleHours}小时',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 第二行：最后一次维保 + 剩余时间
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '最后一次维保：${plan.lastTime}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '剩余：',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              TextSpan(
                                text: plan.formattedRemaining,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primaryOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 显示奶厅选择页面
  void _showFarmSelector(BuildContext context) {
    GoRouter.of(context).push('/select-farm');
  }
}
