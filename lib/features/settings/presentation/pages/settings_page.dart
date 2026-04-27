import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/settings_provider.dart';

/// 系统设置页面
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmPushState = ref.watch(alarmPushNotifierProvider);
    final clearCache = ref.read(clearCacheProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryOrange,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: const Text(
          '系统设置',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => context.go('/personal-center'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 设置卡片（包含两个设置项）
          Card(
            child: Column(
              children: [
                // 异常告警推送开关
                ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('异常告警推送'),
                  subtitle: const Text('接收设备异常告警通知'),
                  trailing: alarmPushState.when(
                    loading: () => const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (e, st) => const Icon(Icons.error, color: AppColors.errorRed),
                    data: (enabled) => Switch(
                      value: enabled,
                      activeTrackColor: AppColors.successGreen.withAlpha(128),
                      activeThumbColor: AppColors.successGreen,
                      onChanged: (value) {
                        ref.read(alarmPushNotifierProvider.notifier).setEnabled(value);
                      },
                    ),
                  ),
                ),
                const Divider(height: 1),
                // 清除缓存
                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: const Text('清除缓存'),
                  subtitle: const Text('清理应用本地缓存数据'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showClearCacheDialog(context, clearCache),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, Future<void> Function() clearCache) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除本地缓存数据吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              // 显示加载中对话框
              late BuildContext loadingCtx;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) {
                  loadingCtx = ctx;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );

              await clearCache();

              if (loadingCtx.mounted) {
                Navigator.of(loadingCtx).pop();
              }

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('缓存已清除'),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}