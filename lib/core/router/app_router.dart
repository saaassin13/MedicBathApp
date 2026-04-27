import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/select_farm_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/data/presentation/pages/data_page.dart';
import '../../features/records/presentation/pages/records_page.dart';
import '../../features/fault_log/presentation/pages/fault_log_page.dart';
import '../../features/maintenance_plan/presentation/pages/maintenance_plan_page.dart';
import '../../features/maintenance_record/presentation/pages/maintenance_record_page.dart';
import '../../features/personal_center/presentation/pages/personal_center_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/widgets/bottom_nav_scaffold.dart';

/// 应用路由配置
/// 10个页面路由
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/select-farm',
      builder: (context, state) => const SelectFarmPage(),
    ),
    // 底部导航页面（使用 ShellRoute 包裹）
    ShellRoute(
      builder: (context, state, child) => BottomNavScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/data',
          builder: (context, state) => const DataPage(),
        ),
        GoRoute(
          path: '/records',
          builder: (context, state) => const RecordsPage(),
        ),
        GoRoute(
          path: '/personal-center',
          builder: (context, state) => const PersonalCenterPage(),
        ),
      ],
    ),
    // 独立页面（无底部导航）
    GoRoute(
      path: '/fault-log',
      builder: (context, state) => const FaultLogPage(),
    ),
    GoRoute(
      path: '/maintenance-plan',
      builder: (context, state) => const MaintenancePlanPage(),
    ),
    GoRoute(
      path: '/maintenance-record',
      builder: (context, state) => const MaintenanceRecordPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
