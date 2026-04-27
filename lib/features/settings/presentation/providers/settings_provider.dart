import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/settings_repository.dart';
import '../../data/mock_settings_repository.dart';

/// Settings Repository Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return MockSettingsRepository();
});

/// 告警推送开关状态 Provider
final alarmPushEnabledProvider = FutureProvider<bool>((ref) async {
  final repository = ref.watch(settingsRepositoryProvider);
  return repository.getAlarmPushEnabled();
});

/// 告警推送状态管理器
class AlarmPushNotifier extends StateNotifier<AsyncValue<bool>> {
  final SettingsRepository _repository;

  AlarmPushNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadInitialValue();
  }

  Future<void> _loadInitialValue() async {
    state = const AsyncValue.loading();
    try {
      final value = await _repository.getAlarmPushEnabled();
      state = AsyncValue.data(value);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setEnabled(bool enabled) async {
    try {
      await _repository.setAlarmPushEnabled(enabled);
      state = AsyncValue.data(enabled);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// 告警推送状态管理器 Provider
final alarmPushNotifierProvider =
    StateNotifierProvider<AlarmPushNotifier, AsyncValue<bool>>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return AlarmPushNotifier(repository);
});

/// 清除缓存操作 Provider
final clearCacheProvider = Provider<Future<void> Function()>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return () => repository.clearCache();
});