import '../domain/settings_repository.dart';

/// Mock 系统设置仓库实现
class MockSettingsRepository implements SettingsRepository {
  bool _alarmPushEnabled = true;

  @override
  Future<bool> getAlarmPushEnabled() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _alarmPushEnabled;
  }

  @override
  Future<void> setAlarmPushEnabled(bool enabled) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _alarmPushEnabled = enabled;
  }

  @override
  Future<void> clearCache() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // 模拟清除缓存操作
  }
}