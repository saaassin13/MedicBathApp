import 'entities.dart';

/// 首页仓库接口
abstract class HomeRepository {
  /// 获取首页数据
  Future<HomePageData> getHomePageData();

  /// 获取报警状态
  Future<AlarmStatus> getAlarmStatus();

  /// 刷新数据
  Future<void> refresh();
}
