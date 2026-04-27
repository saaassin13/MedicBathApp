import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/personal_center_provider.dart';

/// 我的页面
class PersonalCenterPage extends ConsumerWidget {
  const PersonalCenterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoAsync = ref.watch(userInfoProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: const Text('个人中心'),
      ),
      body: Column(
        children: [
          // 橙色背景区域
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.primaryOrange,
            ),
            child: userInfoAsync.when(
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
              data: (userInfo) => Row(
                children: [
                  Text(
                    '${userInfo.name}-${userInfo.department}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '个人信息',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ),
          // 白色背景区域
          Expanded(
            child: Container(
              color: AppColors.backgroundGray,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 业务入口（无标题）
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.assignment_turned_in, color: AppColors.primaryOrange),
                          title: const Text('维保计划'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/maintenance-plan'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.history, color: AppColors.primaryOrange),
                          title: const Text('维保记录'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/maintenance-record'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.bug_report, color: AppColors.primaryOrange),
                          title: const Text('故障日志'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/fault-log'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 系统入口（无标题）
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.settings, color: AppColors.primaryOrange),
                          title: const Text('系统设置'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/settings'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.system_update, color: AppColors.primaryOrange),
                          title: const Text('检查更新'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showUpdateDialog(context),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.info, color: AppColors.primaryOrange),
                          title: const Text('关于我们'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _showAboutDialog(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 退出登录按钮
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(color: AppColors.primaryOrange),
                      ),
                      onPressed: () => _handleLogout(context, ref),
                      child: const Text(
                        '退出登录',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('检查更新'),
        content: const Text('当前已是最新版本'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于我们'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('智慧牧场管理系统'),
            SizedBox(height: 8),
            Text('版本：1.0.0'),
            SizedBox(height: 8),
            Text('提供牧场数字化管理解决方案'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
