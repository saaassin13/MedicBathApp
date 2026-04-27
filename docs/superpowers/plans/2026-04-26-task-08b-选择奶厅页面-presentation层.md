# Task 8b: 认证模块 - 选择奶厅页面 Presentation 层

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建选择奶厅页面的 Presentation 层，包含页面 UI、搜索功能和奶厅选择逻辑

**Architecture:** 认证模块 presentation 层，Riverpod 状态管理

**Tech Stack:** Riverpod Provider, GoRouter, SelectFarmPage

**前置任务:** Task 6 (Auth Domain), Task 7 (Auth Data), Task 8a (登录页面和 auth_provider)

**依赖文件:**
- `lib/features/auth/presentation/providers/auth_provider.dart` (Task 8a) - 包含 farmsProvider, farmSearchProvider, filteredFarmsProvider
- `lib/features/auth/domain/farm.dart` (Task 6)
- `lib/shared/providers/farm_selection_provider.dart` (Task 18)

---

## Files

- Create: `lib/features/auth/presentation/pages/select_farm_page.dart`

---

## Step by Step

- [x] **Step 1: 创建 select_farm_page.dart（带搜索功能）**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class SelectFarmPage extends ConsumerWidget {
  const SelectFarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredFarmsAsync = ref.watch(filteredFarmsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: const Text('选择奶厅'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: Column(
        children: [
          // 搜索框
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索奶厅',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                ref.read(farmSearchProvider.notifier).state = value;
              },
            ),
          ),
          // 奶厅列表
          Expanded(
            child: filteredFarmsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('加载失败: $error')),
              data: (farms) {
                if (farms.isEmpty) {
                  return const Center(
                    child: Text('未找到匹配的奶厅', style: TextStyle(color: AppColors.textSecondary)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: farms.length,
                  itemBuilder: (context, index) {
                    final farm = farms[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.home,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                        title: Text(
                          farm.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        onTap: () async {
                          // TODO: 选择奶厅后保存到 FarmSelectionNotifier
          # 需要替换为 Task 18 创建的 farm_selection_provider
          # await ref.read(farmSelectionProvider.notifier).selectFarm(farm);
                          if (context.mounted) {
                            context.go('/home');
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

> **注意**：
> 1. 搜索功能支持按奶厅名称和牧场名称过滤（Provider 在 Task 8a 的 auth_provider.dart 中定义）
> 2. 选择奶厅后的保存逻辑依赖 Task 18 创建的 `farm_selection_provider.dart`
> 3. 当前 onTap 中的 TODO 需要在 Task 18 完成后替换为实际调用

---

## Verification

- [x] 选择奶厅页面显示奶厅列表
- [x] 搜索框可输入并过滤奶厅列表
- [x] 点击奶厅项后跳转到首页
- [x] 点击 X 按钮返回登录页面
- [ ] 选中状态显示橙色边框

---

## 后续任务

- Task 9: 首页模块 Domain/Data 层
- Task 18: 公共服务（farm_selection_provider）
