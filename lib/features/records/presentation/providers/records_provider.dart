import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/records_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_records_repository.dart';

/// 记录仓库 Provider
final recordsRepositoryProvider = Provider<RecordsRepository>((ref) {
  return MockRecordsRepository();
});

/// 记录列表数据 Provider
final recordsProvider = FutureProvider<List<DateGroup>>((ref) async {
  final repository = ref.watch(recordsRepositoryProvider);
  return repository.getRecords();
});