import '../domain/entities.dart';

abstract class FaultLogRepository {
  Future<List<FaultLogItem>> getFaultLogs();
}
