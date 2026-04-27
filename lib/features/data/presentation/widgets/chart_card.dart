import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// 图表卡片组件 - 双轴复合图
class ChartCard extends StatelessWidget {
  final String title;
  final List<String> dates;
  final List<int> cowCounts;
  final List<double> recognitionRates;

  const ChartCard({
    super.key,
    required this.title,
    required this.dates,
    required this.cowCounts,
    required this.recognitionRates,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, size: 18, color: AppColors.primaryOrange),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('药浴牛数（头）', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                const Spacer(),
                const Text('乳头识别率（%）', style: TextStyle(fontSize: 10, color: AppColors.textPrimary)),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 200,
              child: _buildChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    // 固定 chartMaxY = 10000，确保左右刻度对齐
    // 左侧间隔 = 10000 / 5 = 2000（对应右侧 20%）
    const chartMaxY = 10000.0;
    const interval = 2000.0;

    return LineChart(
      LineChartData(
        maxY: chartMaxY,
        minY: 0,
        minX: -0.5,
        maxX: cowCounts.length - 0.5,
        lineBarsData: _buildAllBars(chartMaxY),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: 1,
              getTitlesWidget: (value, meta) {
                // 严格过滤：只接受精确整数位且在有效范围内
                final rounded = value.round();
                if (rounded < 0 || rounded >= dates.length) {
                  return const SizedBox.shrink();
                }
                if ((value - rounded).abs() > 0.01) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    dates[rounded],
                    style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: interval.toDouble(),
              getTitlesWidget: (value, meta) {
                return Text(
                  _formatValue(value.toInt()),
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: interval.toDouble(),
              getTitlesWidget: (value, meta) {
                // 将Y轴坐标转换为百分比显示
                final percent = (value / chartMaxY * 100).round();
                // 只显示0, 20, 40, 60, 80, 100%的刻度
                if (percent == 0 || percent == 20 || percent == 40 ||
                    percent == 60 || percent == 80 || percent == 100) {
                  return Text(
                    '$percent%',
                    style: const TextStyle(fontSize: 10, color: AppColors.textPrimary),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval.toDouble(),
          getDrawingHorizontalLine: (value) {
            return FlLine(color: AppColors.textHint, strokeWidth: 1);
          },
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                if (spot.barIndex == 0) {
                  final percent = (spot.y / chartMaxY * 100);
                  return LineTooltipItem(
                    '${percent.toStringAsFixed(1)}%',
                    const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold),
                  );
                }
                return LineTooltipItem(
                  '${spot.y.toInt()}头',
                  const TextStyle(color: AppColors.chartDarkBlue, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  /// 构建折线图数据 - 首尾延伸超出边界
  List<FlSpot> _buildLineSpots(double chartMaxY) {
    if (recognitionRates.isEmpty) return [];
    final spots = <FlSpot>[];

    // 第一个点之前延伸出去
    spots.add(FlSpot(-0.5, recognitionRates[0] / 100 * chartMaxY));
    for (int i = 0; i < recognitionRates.length; i++) {
      spots.add(FlSpot(i.toDouble(), recognitionRates[i] / 100 * chartMaxY));
    }
    // 最后一个点之后延伸出去
    spots.add(FlSpot((recognitionRates.length - 0.5).toDouble(),
        recognitionRates[recognitionRates.length - 1] / 100 * chartMaxY));

    return spots;
  }

  /// 构建所有线条数据
  List<LineChartBarData> _buildAllBars(double chartMaxY) {
    final bars = <LineChartBarData>[];

    // 折线图 - 乳头识别率(橙色)
    bars.add(
      LineChartBarData(
        spots: _buildLineSpots(chartMaxY),
        isCurved: true,
        curveSmoothness: 0.3,
        color: AppColors.primaryOrange,
        barWidth: 2,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            // 只在有效数据点(index 1 到 length)位置显示圆点
            if (index == 0 || index == recognitionRates.length + 1) {
              // 延伸点不显示圆点
              return FlDotCirclePainter(radius: 0, color: Colors.transparent);
            }
            return FlDotCirclePainter(
              radius: 4,
              color: Colors.white,
              strokeWidth: 2,
              strokeColor: AppColors.primaryOrange,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
      ),
    );

    // 柱状图 - 宽度0.6
    for (int i = 0; i < cowCounts.length; i++) {
      if (cowCounts[i] > 0) {
        bars.add(
          LineChartBarData(
            spots: [
              FlSpot(i.toDouble() - 0.30, 0),
              FlSpot(i.toDouble() - 0.30, cowCounts[i].toDouble()),
              FlSpot(i.toDouble() + 0.30, cowCounts[i].toDouble()),
              FlSpot(i.toDouble() + 0.30, 0),
            ],
            isCurved: false,
            color: AppColors.chartBlue,
            barWidth: 0,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.chartBlue,
              cutOffY: 0,
              applyCutOffY: true,
            ),
          ),
        );
      }
    }

    return bars;
  }

  String _formatValue(int value) {
    if (value >= 1000) {
      final k = value / 1000;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}k';
    }
    return value.toString();
  }
}
