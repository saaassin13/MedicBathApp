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
