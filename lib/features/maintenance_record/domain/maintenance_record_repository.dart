import '../domain/entities.dart';

abstract class MaintenanceRecordRepository {
  Future<List<MaintenanceRecordItem>> getMaintenanceRecords();
}
