import '../domain/personal_center_repository.dart';
import '../domain/entities.dart';

/// Mock 个人中心仓库实现
class MockPersonalCenterRepository implements PersonalCenterRepository {
  @override
  Future<UserInfo> getUserInfo() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const UserInfo(
      name: '张三',
      department: '牧场管理部',
    );
  }

  @override
  List<EntryItem> getBusinessEntries() {
    return const [
      EntryItem(name: '维保计划', icon: 'engineering'),
      EntryItem(name: '维保记录', icon: 'history'),
      EntryItem(name: '故障日志', icon: 'bug_report'),
    ];
  }

  @override
  List<EntryItem> getSystemEntries() {
    return const [
      EntryItem(name: '系统设置', icon: 'settings'),
      EntryItem(name: '检查更新', icon: 'update'),
      EntryItem(name: '关于我们', icon: 'info'),
    ];
  }
}
