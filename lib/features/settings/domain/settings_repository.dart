/// 系统设置仓库接口
abstract class SettingsRepository {
  /// 获取异常告警推送开关状态
  Future<bool> getAlarmPushEnabled();

  /// 设置异常告警推送开关状态
  Future<void> setAlarmPushEnabled(bool enabled);

  /// 清除缓存
  Future<void> clearCache();
}