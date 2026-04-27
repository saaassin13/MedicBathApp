import 'package:flutter/material.dart';
import 'error_logger.dart';

/// 错误上报服务
///
/// 本地日志已实现，上报后端 API 预留接口
/// 后续对接时实现 HttpReporter 类并替换本类中的调用
class ErrorReporter {
  /// 上报错误到后端
  ///
  /// 当前实现：仅记录到本地日志
  /// 后续实现：同时发送到后端错误收集 API
  static Future<void> report(FlutterErrorDetails details) async {
    // 记录到本地日志
    await ErrorLogger.log(
      details.exceptionAsString(),
      stackTrace: details.stack?.toString(),
    );

    // 上报后端（预留接口，后续通过 HttpReporter 实现）
    // _sendToBackend(...);
  }

  /// 上报普通异常
  ///
  /// 当前实现：仅记录到本地日志
  /// 后续实现：同时发送到后端错误收集 API
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

    // 上报后端（预留接口，后续通过 HttpReporter 实现）
    // _sendExceptionToBackend(...);
  }
}
