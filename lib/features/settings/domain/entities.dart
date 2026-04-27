/// 设置项实体
class SettingItem {
  final String name;
  final String icon;
  final SettingType type;
  final bool? value;

  const SettingItem({
    required this.name,
    required this.icon,
    required this.type,
    this.value,
  });
}

/// 设置类型
enum SettingType {
  /// 开关类型
  switchType,
  /// 操作类型
  action,
}