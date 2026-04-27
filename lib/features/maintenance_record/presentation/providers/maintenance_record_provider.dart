import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/maintenance_record_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_maintenance_record_repository.dart';

final maintenanceRecordRepositoryProvider = Provider<MaintenanceRecordRepository>((ref) {
  return MockMaintenanceRecordRepository();
});

final maintenanceRecordsProvider = FutureProvider<List<MaintenanceRecordItem>>((ref) async {
  final repository = ref.watch(maintenanceRecordRepositoryProvider);
  return repository.getMaintenanceRecords();
});
