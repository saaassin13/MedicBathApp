import '../domain/entities.dart';

/// 个人中心仓库接口
abstract class PersonalCenterRepository {
  /// 获取用户信息
  Future<UserInfo> getUserInfo();

  /// 获取业务入口列表
  List<EntryItem> getBusinessEntries();

  /// 获取系统入口列表
  List<EntryItem> getSystemEntries();
}
