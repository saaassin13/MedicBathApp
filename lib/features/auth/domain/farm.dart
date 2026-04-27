/// 奶厅实体
class Farm {
  final String id;
  final String name;
  final String farmName;
  final String period;
  final String number;

  const Farm({
    required this.id,
    required this.name,
    required this.farmName,
    required this.period,
    required this.number,
  });

  /// 显示名称，格式：牧场名称-期数奶厅-编号转盘
  String get displayName => '$farmName-$period-$number';
}