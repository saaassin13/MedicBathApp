import '../domain/maintenance_record_repository.dart';
import '../domain/entities.dart';

class MockMaintenanceRecordRepository implements MaintenanceRecordRepository {
  @override
  Future<List<MaintenanceRecordItem>> getMaintenanceRecords() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      MaintenanceRecordItem(
        timestamp: '04/26 08:30:00.125',
        status: '已完成',
        taskName: '机器人关节检查',
        taskType: '定期保养',
      ),
      MaintenanceRecordItem(
        timestamp: '04/26 09:15:30.456',
        status: '已完成',
        taskName: '相机校准',
        taskType: '定期保养',
      ),
      MaintenanceRecordItem(
        timestamp: '04/26 10:00:15.789',
        status: '已完成',
        taskName: '传感器清洁',
        taskType: '日常维护',
      ),
      MaintenanceRecordItem(
        timestamp: '04/26 11:30:45.321',
        status: '已完成',
        taskName: '润滑系统检查',
        taskType: '定期保养',
      ),
    ];
  }
}
