import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/data_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_data_repository.dart';

/// 数据仓库提供者
final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return MockDataRepository();
});

/// 数据页面数据提供者
final dataPageDataProvider = FutureProvider<DataPageData>((ref) async {
  final repository = ref.watch(dataRepositoryProvider);
  return repository.getDataPageData();
});
