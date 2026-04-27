# Bug #005：StatusCard stretch 布局导致无限高度错误

**现象**：`BoxConstraints forces an infinite height`

**根因**：`Row` 使用 `crossAxisAlignment: CrossAxisAlignment.stretch` 配合 `Expanded` 子元素，但 Row 位于 `ListView` 中，`ListView` 提供无界高度约束，导致 `Expanded` 被要求无限拉伸。

**修复方案**：
1. 使用 `IntrinsicHeight` 包裹 Row，让两个 `Expanded` 子卡片使用相同高度（基于最大内容计算），既实现等高又自适应
2. 移除固定 `SizedBox` 高度

```dart
IntrinsicHeight(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(child: StatusCard(...)),  // 3项
      Expanded(child: StatusCard(...)),  // 2项 → 取最大高度
    ],
  ),
)
```

**验证方法**：
1. 重新运行应用
2. 进入首页，确认两个状态卡片高度一致
3. 确认无布局错误日志
