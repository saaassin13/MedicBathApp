import '../domain/entities.dart';

/// 记录仓库接口
abstract class RecordsRepository {
  /// 获取按日期分组的记录列表
  Future<List<DateGroup>> getRecords();
}