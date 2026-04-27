import 'package:flutter/material.dart';
import 'error_logger.dart';

/// 错误上报服务
class ErrorReporter {
  /// 上报错误到后端
  static Future<void> report(FlutterErrorDetails details) async {
    // 记录到本地日志
    await ErrorLogger.log(
      details.exceptionAsString(),
      stackTrace: details.stack?.toString(),
    );

    // TODO: 发送到后端错误收集 API
    // 示例代码（需要根据实际后端接口调整）：
    // try {
    //   await Dio().post('https://api.example.com/errors', data: {
    //     'message': details.exceptionAsString(),
    //     'stackTrace': details.stack?.toString(),
    //     'deviceInfo': 'Flutter App',
    //     'timestamp': DateTime.now().toIso8601String(),
    //   });
    // } catch (e) {
    //   debugPrint('Failed to report error: $e');
    // }
  }

  /// 上报普通异常
  static Future<void> reportException(Exception exception, {
    StackTrace? stackTrace,
    String? page,
    String? userId,
  }) async {
    await ErrorLogger.log(
      exception.toString(),
      stackTrace: stackTrace?.toString(),
      page: page,
      userId: userId,
    );

    // TODO: 发送到后端错误收集 API
  }
}
