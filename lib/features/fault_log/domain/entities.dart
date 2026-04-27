/// 故障日志级别
enum FaultLevel {
  error,   // 错误 - 红色
  warning, // 警告 - 橙色
  info,    // 提示 - 绿色
}

/// 故障日志项
class FaultLogItem {
  final String timestamp; // MM/dd HH:mm:ss.SSS
  final FaultLevel level;
  final String description;

  const FaultLogItem({
    required this.timestamp,
    required this.level,
    required this.description,
  });

  String get levelLabel {
    switch (level) {
      case FaultLevel.error:
        return '错误';
      case FaultLevel.warning:
        return '警告';
      case FaultLevel.info:
        return '提示';
    }
  }
}
