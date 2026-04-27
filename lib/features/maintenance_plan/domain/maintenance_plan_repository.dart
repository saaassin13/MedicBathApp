import '../domain/entities.dart';

abstract class MaintenancePlanRepository {
  Future<List<MaintenancePlanItem>> getMaintenancePlans();
}
