// 数据页面实体类

class ChartData {
  final List<String> dates;
  final List<int> cowCounts;
  final List<double> recognitionRates;

  const ChartData({
    required this.dates,
    required this.cowCounts,
    required this.recognitionRates,
  });
}

/// 药液用量图表数据
class UsageChartData {
  final List<String> dates;
  final List<double> dailyUsage; // 每日用量（mL）

  const UsageChartData({
    required this.dates,
    required this.dailyUsage,
  });
}

class UsageStats {
  final double totalUsage;
  final double avgUsage;
  final double maxDailyUsage;
  final String maxDailyDate;

  const UsageStats({
    required this.totalUsage,
    required this.avgUsage,
    required this.maxDailyUsage,
    required this.maxDailyDate,
  });
}

class CoverageStats {
  final String type;
  final int count;
  final int percentage;

  const CoverageStats({
    required this.type,
    required this.count,
    required this.percentage,
  });
}

class DataPageData {
  final ChartData chartData;
  final UsageChartData usageChartData;
  final UsageStats usageStats;
  final List<CoverageStats> coverageStats;

  const DataPageData({
    required this.chartData,
    required this.usageChartData,
    required this.usageStats,
    required this.coverageStats,
  });
}
