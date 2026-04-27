import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/maintenance_plan_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_maintenance_plan_repository.dart';

final maintenancePlanRepositoryProvider = Provider<MaintenancePlanRepository>((ref) {
  return MockMaintenancePlanRepository();
});

final maintenancePlansProvider = FutureProvider<List<MaintenancePlanItem>>((ref) async {
  final repository = ref.watch(maintenancePlanRepositoryProvider);
  return repository.getMaintenancePlans();
});
