import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/farm_selection_provider.dart';
import '../providers/auth_provider.dart';

class SelectFarmPage extends ConsumerWidget {
  const SelectFarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredFarmsAsync = ref.watch(filteredFarmsProvider);
    final selectedFarm = ref.watch(selectedFarmProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryOrange,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: const Text(
          '选择奶厅',
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              final router = GoRouter.of(context);
              if (router.canPop()) {
                router.pop();
              } else {
                router.go('/home');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索奶厅',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.primaryOrange),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                ref.read(farmSearchProvider.notifier).state = value;
              },
            ),
          ),
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
                    final isSelected = selectedFarm?.id == farm.id;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected ? AppColors.primaryOrange : Colors.grey.shade200,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      elevation: isSelected ? 2 : 0,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.warehouse,
                            color: AppColors.primaryOrange,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          farm.displayName,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                        trailing: isSelected ? const Icon(Icons.check, color: AppColors.primaryOrange) : null,
                        onTap: () {
                          ref.read(farmSelectionProvider.notifier).selectFarm(farm);
                          final router = GoRouter.of(context);
                          if (router.canPop()) {
                            router.pop();
                          } else {
                            router.go('/home');
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '点击或下拉加载更多...',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
