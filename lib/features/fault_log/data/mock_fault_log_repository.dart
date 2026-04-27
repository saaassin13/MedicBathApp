import '../domain/fault_log_repository.dart';
import '../domain/entities.dart';

class MockFaultLogRepository implements FaultLogRepository {
  @override
  Future<List<FaultLogItem>> getFaultLogs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      FaultLogItem(
        timestamp: '03/07 11:49:55.099',
        level: FaultLevel.error,
        description: '相机连接断开',
      ),
      FaultLogItem(
        timestamp: '03/07 11:49:52.083',
        level: FaultLevel.error,
        description: '机器人连接断开',
      ),
      FaultLogItem(
        timestamp: '03/07 11:49:50.999',
        level: FaultLevel.warning,
        description: '编码器电池过期',
      ),
      FaultLogItem(
        timestamp: '03/07 11:49:48.055',
        level: FaultLevel.info,
        description: '药浴任务开始',
      ),
    ];
  }
}
