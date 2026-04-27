# Bug #006：MonitorCard 硬编码高度导致机型不适配

**现象**：监控画面固定高度 140px，在不同屏幕尺寸上表现不一致（小屏过大，大屏过小）。

**根因**：多处使用固定像素值：
- 监控画面高度：`140px`
- 监控图标：`48px`
- 状态/视角字号：`10px`
- 放大图标：`20px`

**修复方案**：使用 `MediaQuery` 动态计算，基于 `screenHeight` 比例：

```dart
final screenHeight = MediaQuery.of(context).size.height;

Container(
  height: screenHeight * 0.16,           // 替代固定 140
  child: Icon(size: screenHeight * 0.04),  // 替代固定 48
  child: Text(fontSize: screenHeight * 0.012),  // 替代固定 10-12
)
```

| 用途 | 固定值 | 比例值 |
|------|--------|--------|
| 监控画面高度 | 140px | `screenHeight * 0.16` |
| 监控图标 | 48px | `screenHeight * 0.04` |
| 状态/视角字号 | 10px | `screenHeight * 0.012` |
| 放大图标 | 20px | `screenHeight * 0.022` |

**验证方法**：
1. 在不同尺寸模拟器上测试
2. 确认监控画面高度自适应
3. 确认状态/视角文字可读
