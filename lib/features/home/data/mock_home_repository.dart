import '../domain/home_repository.dart';
import '../domain/entities.dart';

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
