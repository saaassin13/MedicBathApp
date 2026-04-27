/// 维保计划项
class MaintenancePlanItem {
  final String name;
  final int cycleHours;
  final String lastTime;
  final int remainingDays;
  final int remainingHours;

  const MaintenancePlanItem({
    required this.name,
    required this.cycleHours,
    required this.lastTime,
    required this.remainingDays,
    required this.remainingHours,
  });

  String get formattedRemaining {
    final days = remainingDays.toString().padLeft(2, '0');
    final hours = remainingHours.toString().padLeft(2, '0');
    return '$days天$hours小时';
  }
}
