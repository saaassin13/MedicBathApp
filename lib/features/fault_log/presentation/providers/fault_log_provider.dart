import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/fault_log_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_fault_log_repository.dart';

final faultLogRepositoryProvider = Provider<FaultLogRepository>((ref) {
  return MockFaultLogRepository();
});

final faultLogsProvider = FutureProvider<List<FaultLogItem>>((ref) async {
  final repository = ref.watch(faultLogRepositoryProvider);
  return repository.getFaultLogs();
});
