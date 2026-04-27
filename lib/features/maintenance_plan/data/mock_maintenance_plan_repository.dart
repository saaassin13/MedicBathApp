import '../domain/entities.dart';
import '../domain/maintenance_plan_repository.dart';

/// 模拟维保计划仓库，8个维保项目按剩余时间升序排列
class MockMaintenancePlanRepository implements MaintenancePlanRepository {
  @override
  Future<List<MaintenancePlanItem>> getMaintenancePlans() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 300));

    final items = [
      const MaintenancePlanItem(
        name: '空压机更换机油',
        cycleHours: 2000,
        lastTime: '2026/04/01 08:30',
        remainingDays: 2,
        remainingHours: 15,
      ),
      const MaintenancePlanItem(
        name: '冷却系统检查',
        cycleHours: 1000,
        lastTime: '2026/03/15 14:20',
        remainingDays: 5,
        remainingHours: 8,
      ),
      const MaintenancePlanItem(
        name: '电机轴承润滑',
        cycleHours: 3000,
        lastTime: '2026/02/20 10:00',
        remainingDays: 8,
        remainingHours: 22,
      ),
      const MaintenancePlanItem(
        name: '液压油更换',
        cycleHours: 4000,
        lastTime: '2026/01/10 09:15',
        remainingDays: 12,
        remainingHours: 5,
      ),
      const MaintenancePlanItem(
        name: '过滤器清洁',
        cycleHours: 500,
        lastTime: '2026/04/10 16:45',
        remainingDays: 15,
        remainingHours: 12,
      ),
      const MaintenancePlanItem(
        name: '皮带张力检查',
        cycleHours: 1500,
        lastTime: '2026/03/01 11:30',
        remainingDays: 20,
        remainingHours: 18,
      ),
      const MaintenancePlanItem(
        name: '电气接线检查',
        cycleHours: 2500,
        lastTime: '2026/02/05 08:00',
        remainingDays: 28,
        remainingHours: 3,
      ),
      const MaintenancePlanItem(
        name: '整体精度校准',
        cycleHours: 6000,
        lastTime: '2025/12/20 13:25',
        remainingDays: 35,
        remainingHours: 10,
      ),
    ];

    // 按剩余时间升序排列（剩余天数少的在前）
    items.sort((a, b) {
      final aTotalHours = a.remainingDays * 24 + a.remainingHours;
      final bTotalHours = b.remainingDays * 24 + b.remainingHours;
      return aTotalHours.compareTo(bTotalHours);
    });

    return items;
  }
}
