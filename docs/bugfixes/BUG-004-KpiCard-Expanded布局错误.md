# Bug #004：KpiCard Expanded 布局错误 + 屏幕自适应

**现象**：
1. `RenderFlex children have non-zero flex but incoming height constraints are unbounded`
2. KPI 卡片固定高度在不同机型上不适配

**根因**：
1. `KpiCard` 位于 `ListView` 中，Expanded 无法在无界约束下工作
2. 使用固定像素值（100px、24px 等）导致不同屏幕尺寸表现不一致

**修复方案**：
1. 使用 `AspectRatio(aspectRatio: 1.6)` 替代固定高度
2. 使用 `MediaQuery` 动态计算字号和间距

```dart
final screenHeight = MediaQuery.of(context).size.height;

Card(
  child: AspectRatio(
    aspectRatio: 1.6,
    child: Padding(
      padding: EdgeInsets.all(screenHeight * 0.012),
      child: Column(
        children: [
          Row([图标, 标题]),  // 字号: screenHeight * 0.012
          Expanded(
            child: Center(
              child: Row([数值, 单位]),  // 数值字号: screenHeight * 0.024
            ),
          ),
        ],
      ),
    ),
  ),
)
```

**验证方法**：
1. 在不同尺寸模拟器上测试
2. 确认 KPI 卡片高度自适应
3. 确认无布局错误日志
