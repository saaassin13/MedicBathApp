# 奶牛药浴移动端 - Claude Code 项目文档

> 本文件是 Claude Code 的项目上下文文档，每次会话启动时会自动加载。

---

## 项目概述

**项目名称：** 奶牛药浴大数据管理中心移动端
**包名：** dairy_cow_teat_dipping
**Flutter 版本：** 3.x

**目标：** 创建完整的 Flutter 移动端应用，包含全部 10 个页面、消息提醒系统和异常处理系统

**架构：** Clean Architecture（4层分离）+ Riverpod 状态管理 + GoRouter 声明式路由

---

## 技术栈

| 技术 | 用途 |
|------|------|
| Flutter 3.x | 跨平台移动端框架 |
| flutter_riverpod ^2.4.0 | 状态管理 |
| go_router ^13.0.0 | 声明式路由 |
| hive ^2.2.3 + hive_flutter ^1.1.0 | 本地数据存储 |
| fl_chart ^0.65.0 | 图表组件 |
| flutter_local_notifications ^16.0.0 | 系统推送 |
| overlay_support ^2.0.0 | 应用内弹窗 |
| dio ^5.4.0 | 网络请求 |
| shared_preferences ^2.2.0 | 轻量级本地存储 |
| intl ^0.18.0 | 国际化/日期格式化 |

---

## 目录结构

```
lib/
├── main.dart                      # 应用入口
├── app.dart                       # MaterialApp 配置
│
├── core/                          # 核心层
│   ├── constants/
│   │   └── app_constants.dart     # 应用常量
│   ├── router/
│   │   └── app_router.dart         # GoRouter 路由配置（10个页面）
│   ├── theme/
│   │   ├── app_colors.dart         # 颜色配置（橙色品牌色）
│   │   └── app_theme.dart          # 主题配置
│   └── utils/
│       └── date_utils.dart         # 日期工具类
│
├── features/                      # 功能模块（9个）
│   ├── auth/
│   │   ├── data/
│   │   │   └── mock_auth_repository.dart
│   │   ├── domain/
│   │   │   ├── user.dart
│   │   │   ├── farm.dart
│   │   │   └── auth_repository.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── select_farm_page.dart
│   │       └── providers/
│   │           └── auth_provider.dart
│   │
│   ├── home/
│   │   ├── data/
│   │   │   └── mock_home_repository.dart
│   │   ├── domain/
│   │   │   ├── entities.dart
│   │   │   └── home_repository.dart
│   │   └── presentation/
│   │       ├── pages/home_page.dart
│   │       ├── providers/home_provider.dart
│   │       └── widgets/
│   │           ├── kpi_card.dart
│   │           ├── monitor_card.dart
│   │           └── status_card.dart
│   │
│   ├── data/                       # 数据页面（图表展示）
│   ├── records/                     # 记录页面（按日期分组）
│   ├── fault_log/                   # 故障日志（三级颜色）
│   ├── maintenance_plan/             # 维保计划（按剩余时间排序）
│   ├── maintenance_record/           # 维保记录
│   ├── personal_center/              # 个人中心
│   └── settings/                    # 系统设置
│
├── services/                       # 公共服务层
│   ├── error/
│   │   ├── error_logger.dart        # 本地错误日志（Hive）
│   │   └── error_reporter.dart      # 错误上报（预留后端接口）
│   ├── notification/
│   │   └── notification_service.dart  # 消息服务（推送+横幅+弹窗）
│   └── storage/
│       └── local_storage_service.dart  # 本地存储（Token/用户/奶厅）
│
└── shared/                          # 共享层
    ├── providers/
    │   └── farm_selection_provider.dart  # 奶厅选择全局状态
    └── widgets/
        ├── bottom_nav_scaffold.dart
        ├── status_tag.dart
        └── loading_card.dart
```

---

## 页面路由（10个）

| 页面 | 路由路径 | 说明 |
|------|----------|------|
| 登录 | `/login` | 用户名密码登录 |
| 选择奶厅 | `/select-farm` | 搜索并选择奶厅 |
| 首页 | `/home` | KPI卡片、监控卡片、状态卡片 |
| 数据 | `/data` | 图表、药液用量、覆盖情况 |
| 记录 | `/records` | 按日期分组、中文时长显示 |
| 故障日志 | `/fault-log` | 三级颜色、毫秒时间戳 |
| 维保计划 | `/maintenance-plan` | 按剩余时间排序 |
| 维保记录 | `/maintenance-record` | 毫秒时间戳 |
| 个人中心 | `/personal-center` | 用户信息、功能入口 |
| 系统设置 | `/settings` | 开关、清除缓存 |

---

## 全局 Provider

| Provider | 类型 | 用途 |
|----------|------|------|
| `authNotifierProvider` | StateNotifier | 认证状态管理 |
| `farmsProvider` | FutureProvider | 奶厅列表 |
| `filteredFarmsProvider` | Provider | 奶厅搜索过滤 |
| `farmSelectionProvider` | StateNotifier | 全局奶厅选择状态 |
| `currentFarmDisplayNameProvider` | Provider | 当前奶厅显示名称 |
| `homePageDataProvider` | FutureProvider | 首页数据 |
| `messageServiceProvider` | Provider | 消息服务（待集成） |

---

## 任务进度

| 序号 | 任务 | 状态 |
|------|------|------|
| 1 | Flutter 项目初始化 | ✅ 完成 |
| 2 | 主题配置 | ✅ 完成 |
| 3 | 路由配置 | ✅ 完成 |
| 4 | 常量和工具类 | ✅ 完成 |
| 5 | 共享组件 | ✅ 完成 |
| 6 | 认证模块 Domain 层 | ✅ 完成 |
| 7 | 认证模块 Data 层 | ✅ 完成 |
| 8a | 登录页面 | ✅ 完成 |
| 8b | 选择奶厅页面 | ✅ 完成 |
| 9 | 首页模块 Domain/Data | ✅ 完成 |
| 10 | 首页模块 Presentation | ✅ 完成 |
| 11 | 数据页面模块 | ✅ 完成 |
| 12 | 记录页面模块 | ✅ 完成 |
| 13 | 故障日志模块 | ✅ 完成 |
| 14 | 维保计划模块 | ✅ 完成 |
| 15 | 维保记录模块 | ✅ 完成 |
| 16 | 我的页面模块 | ✅ 完成 |
| 17 | 系统设置模块 | ✅ 完成 |
| 18 | 公共服务 | ✅ 完成 |

---

## 设计规格文档

| 文档 | 路径 |
|------|------|
| 登录页面设计 | `docs/superpowers/specs/2026-04-26-登录页面-design.md` |
| 选择奶厅页面设计 | `docs/superpowers/specs/2026-04-26-选择奶厅页面-design.md` |
| 首页设计 | `docs/superpowers/specs/2026-04-26-首页设计-design.md` |
| 数据页面设计 | `docs/superpowers/specs/2026-04-26-数据页面-design.md` |
| 记录页面设计 | `docs/superpowers/specs/2026-04-26-记录页面-design.md` |
| 故障日志页面设计 | `docs/superpowers/specs/2026-04-26-故障日志页面-design.md` |
| 维保计划页面设计 | `docs/superpowers/specs/2026-04-26-维保计划页面-design.md` |
| 维保记录页面设计 | `docs/superpowers/specs/2026-04-26-维保记录页面-design.md` |
| 我的页面设计 | `docs/superpowers/specs/2026-04-26-我的页面-design.md` |
| 系统设置页面设计 | `docs/superpowers/specs/2026-04-26-系统设置页面-design.md` |
| 技术方案 | `docs/superpowers/specs/2026-04-26-技术方案-design.md` |

---

## 实现计划文档

| 文档 | 路径 |
|------|------|
| 实现计划索引 | `docs/superpowers/plans/2026-04-26-实现计划-索引.md` |
| Task 1: Flutter 项目初始化 | `docs/superpowers/plans/2026-04-26-task-01-flutter-项目初始化.md` |
| Task 2: 主题配置 | `docs/superpowers/plans/2026-04-26-task-02-主题配置.md` |
| Task 3: 路由配置 | `docs/superpowers/plans/2026-04-26-task-03-路由配置.md` |
| Task 4: 常量和工具类 | `docs/superpowers/plans/2026-04-26-task-04-常量和工具类.md` |
| Task 5: 共享组件 | `docs/superpowers/plans/2026-04-26-task-05-共享组件.md` |
| Task 6: 认证模块 Domain 层 | `docs/superpowers/plans/2026-04-26-task-06-认证模块-domain层.md` |
| Task 7: 认证模块 Data 层 | `docs/superpowers/plans/2026-04-26-task-07-认证模块-data层.md` |
| Task 8a: 登录页面 | `docs/superpowers/plans/2026-04-26-task-08a-登录页面-presentation层.md` |
| Task 8b: 选择奶厅页面 | `docs/superpowers/plans/2026-04-26-task-08b-选择奶厅页面-presentation层.md` |
| Task 9: 首页模块 Domain/Data | `docs/superpowers/plans/2026-04-26-task-09-首页模块-domain-data层.md` |
| Task 10: 首页模块 Presentation | `docs/superpowers/plans/2026-04-26-task-10-首页模块-presentation层.md` |
| Task 11-17: 各功能页面 | `docs/superpowers/plans/2026-04-26-task-XX-*.md` |
| Task 18: 公共服务 | `docs/superpowers/plans/2026-04-26-task-18-公共服务.md` |

---

## 品牌色（橙色）

```dart
// AppColors 中的主色调
primaryOrange: Color(0xFFFF6B00)

// 使用场景：按钮、图标高亮、选中状态
```

---

## 常见命令

```bash
# 安装依赖
flutter pub get

# 代码分析
flutter analyze

# 运行应用
flutter run -d emulator-5554

# 构建 debug APK
flutter build apk --debug

# 构建 release APK
flutter build apk --release
```

---

## 待完成项

### 高优先级
1. **消息服务集成** - 各页面尚未集成 MessageService（目前用 SnackBar）
2. **底部导航栏** - 需要用 ShellRoute 包裹实现底部导航

### 中优先级
1. 单元测试（test/ 目录为空）
2. 页面标题栏统一使用 currentFarmDisplayNameProvider
3. 奶厅切换下拉推广到所有页面

### 低优先级
1. 真实 API 对接（目前全为 Mock）
2. 视频播放功能（video_player 已引入未使用）
3. 深色模式

---

## 教训记录

| 编号 | 教训 | 路径 |
|------|------|------|
| LESSON-001 | Mac Android 开发环境配置踩坑 | `docs/lessons-learned/LESSON-001-Mac-Android-开发环境配置.md` |

---

## 构建注意事项

- 首次构建较慢（Gradle 下载依赖），可配置国内镜像加速
- Android Gradle Plugin 版本与 Gradle 版本需匹配
- 模拟器建议使用 x86_64 或 arm64 架构
- **Mac 用户必读：** 首次构建可能需要手动安装 NDK，见教训记录 LESSON-001

---

## 国内镜像配置（Mac/Linux）

### Gradle 镜像（腾讯云，已验证）
编辑 `android/gradle/wrapper/gradle-wrapper.properties`：
```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.12-all.zip
```

### Maven 镜像（阿里云）
编辑 `android/build.gradle.kts` 和 `android/settings.gradle.kts`：
```kotlin
repositories {
    maven { url = uri("https://maven.aliyun.com/repository/google") }
    maven { url = uri("https://maven.aliyun.com/repository/public") }
    maven { url = uri("https://maven.aliyun.com/repository/gradle-plugin") }
    google()
    mavenCentral()
}
```

### NDK
- 暂无可靠的国内 NDK 镜像
- 建议从 Google 官网下载 DMG 后手动安装
- 安装路径：`~/Library/Android/sdk/ndk/<版本号>/`
