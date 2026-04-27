import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/auth/domain/farm.dart';
import '../../../shared/providers/farm_selection_provider.dart';

/// 奶厅选择列表组件
class FarmSelectorList extends ConsumerWidget {
  final List<Farm> farms;

  const FarmSelectorList({super.key, required this.farms});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFarm = ref.watch(selectedFarmProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题栏
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '选择奶厅',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // 奶厅列表
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              final isSelected = selectedFarm?.id == farm.id;

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryOrange.withAlpha(25)
                        : Colors.grey.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.home,
                    color: isSelected ? AppColors.primaryOrange : Colors.grey,
                  ),
                ),
                title: Text(
                  farm.displayName,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.primaryOrange : AppColors.textPrimary,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: AppColors.primaryOrange)
                    : null,
                onTap: () async {
                  final notifier = ref.read(farmSelectionProvider.notifier);
                  await notifier.selectFarm(farm);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
