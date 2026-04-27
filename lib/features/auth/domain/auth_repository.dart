import 'user.dart';
import 'farm.dart';

/// 认证仓库接口
abstract class AuthRepository {
  /// 用户登录
  Future<User> login(String username, String password);

  /// 获取奶厅列表
  Future<List<Farm>> getFarms();

  /// 获取当前用户
  Future<User?> getCurrentUser();

  /// 退出登录
  Future<void> logout();
}