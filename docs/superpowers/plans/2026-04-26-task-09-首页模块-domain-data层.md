# Task 9: 首页模块 - Domain/Data 层

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建首页模块的 Domain 层接口和 Mock Data 层实现

**Architecture:** 首页模块 domain + data 层

**Tech Stack:** Repository Interface, Mock Repository

---

## Files

- Create: `lib/features/home/domain/home_repository.dart`
- Create: `lib/features/home/domain/entities.dart`
- Create: `lib/features/home/data/mock_home_repository.dart`

---

## Step by Step

- [x] **Step 1: 创建 entities.dart**

```dart
/// 首页 KPI 数据
class HomeKpiData {
  final int cowCount;
  final double recognitionRate;
  final double totalUsage;
  final double avgUsage;

  const HomeKpiData({
    required this.cowCount,
    required this.recognitionRate,
    required this.totalUsage,
    required this.avgUsage,
  });
}

/// 设备状态
class DeviceStatus {
  final String name;
  final String status; // normal, warning, error

  const DeviceStatus({
    required this.name,
    required this.status,
  });
}

/// 监控信息
class MonitorInfo {
  final String type;
  final String status;
  final String thumbnailUrl;

  const MonitorInfo({
    required this.type,
    required this.status,
    required this.thumbnailUrl,
  });
}

/// 报警状态
class AlarmStatus {
  final bool hasAlarm;
  final String? description;

  const AlarmStatus({
    required this.hasAlarm,
    this.description,
  });
}

/// 首页数据
class HomePageData {
  final HomeKpiData kpi;
  final AlarmStatus alarm;
  final List<MonitorInfo> monitors;
  final List<DeviceStatus> deviceStatus;
  final List<DeviceStatus> maintenanceStatus;

  const HomePageData({
    required this.kpi,
    required this.alarm,
    required this.monitors,
    required this.deviceStatus,
    required this.maintenanceStatus,
  });
}
```

- [x] **Step 2: 创建 home_repository.dart**

```dart
import 'home_page_data.dart';

/// 首页仓库接口
abstract class HomeRepository {
  /// 获取首页数据
  Future<HomePageData> getHomePageData();

  /// 获取报警状态
  Future<AlarmStatus> getAlarmStatus();

  /// 刷新数据
  Future<void> refresh();
}
```

- [x] **Step 3: 创建 mock_home_repository.dart**

```dart
import '../../domain/home_repository.dart';
import '../../domain/home_page_data.dart';

/// Mock 首页仓库实现
class MockHomeRepository implements HomeRepository {
  @override
  Future<HomePageData> getHomePageData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const HomePageData(
      kpi: HomeKpiData(
        cowCount: 258,
        recognitionRate: 99.8,
        totalUsage: 1250,
        avgUsage: 4.8,
      ),
      alarm: AlarmStatus(hasAlarm: false),
      monitors: [
        MonitorInfo(
          type: '监控视角',
          status: '运行中',
          thumbnailUrl: '',
        ),
        MonitorInfo(
          type: '作业视角',
          status: '运行中',
          thumbnailUrl: '',
        ),
      ],
      deviceStatus: [
        DeviceStatus(name: '药浴机', status: 'normal'),
        DeviceStatus(name: '相机', status: 'normal'),
        DeviceStatus(name: '机器人', status: 'normal'),
        DeviceStatus(name: '光源', status: 'warning'),
        DeviceStatus(name: '图像质量', status: 'normal'),
      ],
      maintenanceStatus: [
        DeviceStatus(name: '螺栓', status: 'warning'),
        DeviceStatus(name: '喷头清洗', status: 'normal'),
        DeviceStatus(name: '编码器', status: 'warning'),
      ],
    );
  }

  @override
  Future<AlarmStatus> getAlarmStatus() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const AlarmStatus(hasAlarm: false);
  }

  @override
  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
```

---

## Verification

- [ ] HomePageData 包含 kpi、alarm、monitors、deviceStatus、maintenanceStatus
- [ ] MockHomeRepository 实现 HomeRepository 接口
- [ ] Mock 数据符合设计规格中的数值