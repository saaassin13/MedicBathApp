# Task 1: Flutter 项目初始化

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建 Flutter 项目骨架，配置 pubspec.yaml 和基础入口文件

**Architecture:** Flutter 3.x + Riverpod，项目初始化

**Tech Stack:** Flutter SDK, pubspec.yaml

---

## Files

- Create: `pubspec.yaml`
- Create: `lib/main.dart`
- Create: `lib/app.dart`

---

## Step by Step

- [x] **Step 1: 创建 pubspec.yaml**

```yaml
name: dairy_cow_teat_dipping
description: 奶牛药浴大数据管理中心移动端
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # 状态管理与路由
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  go_router: ^13.0.0

  # 网络与存储
  dio: ^5.4.0
  shared_preferences: ^2.2.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # UI 组件
  fl_chart: ^0.65.0
  video_player: ^2.8.0
  intl: ^0.18.0

  # 消息提醒
  flutter_local_notifications: ^16.0.0
  overlay_support: ^2.0.0

  # 依赖注入
  get_it: ^7.6.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  hive_generator: ^2.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/mock/
```

- [x] **Step 2: 创建目录结构**

Run: `mkdir -p lib/core/{theme,router,constants,utils} lib/shared/{widgets,models,providers} lib/features/{auth,home,data,records,fault_log,maintenance_plan,maintenance_record,personal_center,settings}/{data/datasources,data/repositories,domain,presentation/{pages,widgets,providers}} lib/services/{mock,storage,notification,error} assets/mock`

- [x] **Step 3: 创建 lib/main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'services/error/error_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Hive
  await Hive.initFlutter();

  // 全局异常捕获
  FlutterError.onError = (details) {
    ErrorLogger.log(details.exceptionAsString());
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };

  runApp(
    const ProviderScope(
      child: DairyCowTeatDippingApp(),
    ),
  );
}
```

- [x] **Step 4: 创建 lib/app.dart**

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class DairyCowTeatDippingApp extends StatelessWidget {
  const DairyCowTeatDippingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '奶牛药浴',
      theme: buildAppTheme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

- [x] **Step 5: 执行 flutter pub get**

Run: `flutter pub get`
Expected: Getting dependencies... (完成)

---

## Verification

- [x] `flutter pub get` 执行成功
- [x] 目录结构创建完成
- [x] main.dart 和 app.dart 无语法错误