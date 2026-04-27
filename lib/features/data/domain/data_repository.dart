import 'entities.dart';

/// 数据仓库抽象接口
abstract class DataRepository {
  Future<DataPageData> getDataPageData();
}
