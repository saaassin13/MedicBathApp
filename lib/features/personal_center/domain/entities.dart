/// 用户信息实体
class UserInfo {
  final String name;
  final String department;
  const UserInfo({required this.name, required this.department});

  String get displayText => '$name - $department';
}

/// 功能入口实体
class EntryItem {
  final String name;
  final String icon;
  const EntryItem({required this.name, required this.icon});
}
