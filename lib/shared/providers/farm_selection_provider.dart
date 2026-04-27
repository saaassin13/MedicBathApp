import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/domain/farm.dart';
import '../../services/storage/local_storage_service.dart';

/// 当前选中的奶厅状态
class FarmSelectionState {
  final Farm? selectedFarm;
  final bool isLoading;

  const FarmSelectionState({
    this.selectedFarm,
    this.isLoading = false,
  });

  FarmSelectionState copyWith({
    Farm? selectedFarm,
    bool? isLoading,
  }) {
    return FarmSelectionState(
      selectedFarm: selectedFarm ?? this.selectedFarm,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 奶厅选择全局状态管理器
class FarmSelectionNotifier extends StateNotifier<FarmSelectionState> {
  FarmSelectionNotifier() : super(const FarmSelectionState()) {
    _loadSavedFarm();
  }

  /// 从本地存储加载已保存的奶厅
  Future<void> _loadSavedFarm() async {
    final savedFarmId = LocalStorageService.getSelectedFarmId();
    if (savedFarmId != null) {
      // 从 AuthRepository 获取奶厅列表，然后查找
      // 这里需要结合 AuthRepository 来加载
      state = state.copyWith(isLoading: false);
    }
  }

  /// 选择奶厅
  Future<void> selectFarm(Farm farm) async {
    state = state.copyWith(isLoading: true);
    await LocalStorageService.saveSelectedFarmId(farm.id);
    state = FarmSelectionState(selectedFarm: farm, isLoading: false);
  }

  /// 清除选择
  Future<void> clearSelection() async {
    state = const FarmSelectionState();
  }

  /// 获取当前奶厅显示名称（用于页面标题）
  String get currentFarmDisplayName {
    return state.selectedFarm?.displayName ?? '未选择奶厅';
  }
}

/// 奶厅选择全局 Provider
final farmSelectionProvider =
    StateNotifierProvider<FarmSelectionNotifier, FarmSelectionState>((ref) {
  return FarmSelectionNotifier();
});

/// 便捷访问：当前选中的奶厅
final selectedFarmProvider = Provider<Farm?>((ref) {
  return ref.watch(farmSelectionProvider).selectedFarm;
});

/// 便捷访问：当前奶厅显示名称
final currentFarmDisplayNameProvider = Provider<String>((ref) {
  final farm = ref.watch(selectedFarmProvider);
  return farm?.displayName ?? '未选择奶厅';
});
