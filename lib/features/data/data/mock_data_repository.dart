import '../domain/data_repository.dart';
import '../domain/entities.dart';

/// 模拟数据仓库实现
class MockDataRepository implements DataRepository {
  @override
  Future<DataPageData> getDataPageData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const DataPageData(
      chartData: ChartData(
        dates: ['04/07', '04/08', '04/09', '04/10', '04/11', '04/12', '04/13'],
        cowCounts: [6200, 7500, 6800, 8200, 7800, 8600, 7100],
        recognitionRates: [85.5, 92.3, 78.6, 95.2, 88.7, 97.1, 82.4],
      ),
      usageChartData: UsageChartData(
        dates: ['04/07', '04/08', '04/09', '04/10', '04/11', '04/12', '04/13'],
        dailyUsage: [11.2, 13.01, 10.85, 12.45, 11.78, 13.12, 10.56],
      ),
      usageStats: UsageStats(
        totalUsage: 1250,
        avgUsage: 4.8,
        maxDailyUsage: 13.12,
        maxDailyDate: '04/13',
      ),
      coverageStats: [
        CoverageStats(type: '未脱杯', count: 50, percentage: 25),
        CoverageStats(type: '防褪链', count: 30, percentage: 15),
        CoverageStats(type: '牛腿过窄', count: 20, percentage: 10),
        CoverageStats(type: '异常跳过', count: 15, percentage: 8),
      ],
    );
  }
}
