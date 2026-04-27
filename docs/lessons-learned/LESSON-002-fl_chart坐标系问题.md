# 教训：fl_chart 的 Stack 叠加无法共享坐标系

**日期**：2026-04-27
**影响范围**：数据页面图表组件

---

## 问题现象

使用 Stack 叠加 BarChart 和 LineChart 实现双轴复合图时：
- 折线图与日期轴对不齐
- 左右 Y 轴刻度位置不一致
- 柱状图宽度与折线图点位置不匹配

## 根本原因

Stack 中的两个 fl_chart 图表虽然视觉上占据相同空间，但内部坐标系是独立的：
- BarChart 使用 `BarChartAlignment.spaceAround` 会自动调整柱状图位置
- LineChart 使用线性 x 坐标 (0, 1, 2, ...)
- 即使设置相同的 `maxY`，刻度映射也会因图表类型不同而异

## 正确做法

使用**单一 LineChart** 绘制所有数据系列：
- 所有系列共享同一个坐标系
- 柱状图通过 `belowBarData` 填充效果模拟
- x/y 位置完全一一对应

## 触发条件

使用 Stack/Positioned 叠加多个 fl_chart 图表时会出现此问题。

## 相关决策

见 [fl_chart双轴复合图方案](../../decisions/2026-04-27-fl_chart双轴复合图方案.md)
