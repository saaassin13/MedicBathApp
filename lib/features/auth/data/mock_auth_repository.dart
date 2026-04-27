import '../domain/auth_repository.dart';
import '../domain/user.dart';
import '../domain/farm.dart';

/// Mock 认证仓库实现
class MockAuthRepository implements AuthRepository {
  // 测试账号
  static const _testUsername = 'test';
  static const _testPassword = 'test123';

  @override
  Future<User> login(String username, String password) async {
    // 模拟登录验证
    await Future.delayed(const Duration(milliseconds: 500));

    // 测试账号验证
    if (username != _testUsername || password != _testPassword) {
      throw Exception('用户名或密码错误');
    }

    // Mock 用户数据
    return const User(
      id: 'user_001',
      name: '张三',
      department: '牧场管理部',
    );
  }

  @override
  Future<List<Farm>> getFarms() async {
    // 模拟获取奶厅列表
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock 奶厅数据
    return const [
      Farm(
        id: 'farm_001',
        name: '双城牧场-一期奶厅-一号转盘',
        farmName: '双城牧场',
        period: '一期奶厅',
        number: '一号转盘',
      ),
      Farm(
        id: 'farm_002',
        name: '双城牧场-一期奶厅-二号转盘',
        farmName: '双城牧场',
        period: '一期奶厅',
        number: '二号转盘',
      ),
      Farm(
        id: 'farm_003',
        name: '双城牧场-二期奶厅-一号转盘',
        farmName: '双城牧场',
        period: '二期奶厅',
        number: '一号转盘',
      ),
      Farm(
        id: 'farm_004',
        name: '双城牧场-二期奶厅-二号转盘',
        farmName: '双城牧场',
        period: '二期奶厅',
        number: '二号转盘',
      ),
    ];
  }

  @override
  Future<User?> getCurrentUser() async {
    // 模拟获取当前用户
    await Future.delayed(const Duration(milliseconds: 200));
    return const User(
      id: 'user_001',
      name: '张三',
      department: '牧场管理部',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}