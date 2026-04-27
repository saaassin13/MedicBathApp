import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app.dart';
import 'services/error/error_logger.dart';
import 'services/error/error_reporter.dart';
import 'services/storage/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Hive
  await Hive.initFlutter();

  // 初始化本地存储
  await LocalStorageService.init();

  // 初始化错误日志
  await ErrorLogger.init();

  // 全局异常捕获
  FlutterError.onError = (details) async {
    await ErrorLogger.log(details.exceptionAsString());
    await ErrorReporter.report(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };

  runApp(
    const ProviderScope(
      child: OverlaySupport(
        child: DairyCowTeatDippingApp(),
      ),
    ),
  );
}