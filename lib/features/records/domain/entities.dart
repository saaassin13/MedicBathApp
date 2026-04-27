/// 记录项
class RecordItem {
  final String startTime;
  final String endTime;
  final int durationSeconds;
  final int cowCount;
  final double recognitionRate;
  final double avgUsage;

  const RecordItem({
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.cowCount,
    required this.recognitionRate,
    required this.avgUsage,
  });

  /// 格式化运行时长 XX小时XX分钟XX秒
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}小时'
        '${minutes.toString().padLeft(2, '0')}分钟'
        '${seconds.toString().padLeft(2, '0')}秒';
  }
}

/// 日期分组记录
class DateGroup {
  final String dateLabel;
  final List<RecordItem> items;

  const DateGroup({
    required this.dateLabel,
    required this.items,
  });
}