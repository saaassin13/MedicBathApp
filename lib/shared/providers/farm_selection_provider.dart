import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/data/mock_auth_repository.dart';
import '../../features/auth/domain/auth_repository.dart';
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
  final AuthRepository _authRepository;

  FarmSelectionNotifier(this._authRepository) : super(const FarmSelectionState()) {
    _loadSavedFarm();
  }

  /// 从本地存储加载已保存的奶厅
  Future<void> _loadSavedFarm() async {
    final savedFarmId = LocalStorageService.getSelectedFarmId();
    if (savedFarmId != null) {
      try {
        final farms = await _authRepository.getFarms();
        final savedFarm = farms.where((f) => f.id == savedFarmId).firstOrNull;
        if (savedFarm != null) {
          state = FarmSelectionState(selectedFarm: savedFarm, isLoading: false);
          return;
        }
      } catch (_) {
        // 加载失败，忽略
      }
    }
    state = state.copyWith(isLoading: false);
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
  // 直接使用 MockAuthRepository，避免循环依赖
  // 后续真实 API 对接时可通过参数传入
  final repository = MockAuthRepository();
  return FarmSelectionNotifier(repository);
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
