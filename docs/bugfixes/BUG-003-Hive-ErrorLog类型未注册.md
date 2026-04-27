# Bug #003：Hive ErrorLog 类型未注册

**现象**：应用启动后反复抛出 `HiveError: Cannot write, unknown type: ErrorLog. Did you forget to register an adapter?`

**根因**：`error_logger.dart` 第 60 行 `await _box?.add(log)` 直接存储 `ErrorLog` 对象，但 Hive 无法序列化自定义 Dart 对象。

**修复方案**：使用 `ErrorLog.toJson()` 将对象转换为 Map 后再存储。`getLogs()` 方法已经正确处理从 Map 到 `ErrorLog` 的转换。

**验证方法**：
1. 重新运行应用
2. 观察日志是否还有 `HiveError` 错误
3. 检查错误日志功能是否正常工作
