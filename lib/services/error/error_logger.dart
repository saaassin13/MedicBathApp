import 'package:hive_flutter/hive_flutter.dart';

/// 错误日志模型
class ErrorLog {
  final String id;
  final String message;
  final String stackTrace;
  final String deviceInfo;
  final DateTime timestamp;
  final String page;
  final String userId;

  ErrorLog({
    required this.id,
    required this.message,
    required this.stackTrace,
    required this.deviceInfo,
    required this.timestamp,
    required this.page,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'stackTrace': stackTrace,
        'deviceInfo': deviceInfo,
        'timestamp': timestamp.toIso8601String(),
        'page': page,
        'userId': userId,
      };
}

/// 本地错误日志服务
class ErrorLogger {
  static const String _boxName = 'error_logs';
  static Box? _box;

  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  /// 记录错误
  static Future<void> log(
    String errorMessage, {
    String? stackTrace,
    String? page,
    String? userId,
  }) async {
    final log = ErrorLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: errorMessage,
      stackTrace: stackTrace ?? '',
      deviceInfo: 'Flutter App',
      timestamp: DateTime.now(),
      page: page ?? 'unknown',
      userId: userId ?? 'anonymous',
    );

    await _box?.add(log.toJson());
  }

  /// 获取所有错误日志
  static List<ErrorLog> getLogs() {
    return _box?.values
        .map((e) => ErrorLog(
              id: e['id'] ?? '',
              message: e['message'] ?? '',
              stackTrace: e['stackTrace'] ?? '',
              deviceInfo: e['deviceInfo'] ?? '',
              timestamp: DateTime.tryParse(e['timestamp'] ?? '') ?? DateTime.now(),
              page: e['page'] ?? '',
              userId: e['userId'] ?? '',
            ))
        .toList() ?? [];
  }

  /// 清空日志
  static Future<void> clear() async {
    await _box?.clear();
  }
}
