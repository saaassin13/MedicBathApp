/// 维保记录项
class MaintenanceRecordItem {
  final String timestamp; // MM/dd HH:mm:ss.SSS
  final String status;
  final String taskName;
  final String taskType;

  const MaintenanceRecordItem({
    required this.timestamp,
    required this.status,
    required this.taskName,
    required this.taskType,
  });
}
