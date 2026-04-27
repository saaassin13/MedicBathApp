import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储服务
class LocalStorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 保存用户 Token
  static Future<void> saveToken(String token) async {
    await _prefs?.setString('auth_token', token);
  }

  /// 获取用户 Token
  static String? getToken() {
    return _prefs?.getString('auth_token');
  }

  /// 保存选中的奶厅 ID
  static Future<void> saveSelectedFarmId(String farmId) async {
    await _prefs?.setString('selected_farm_id', farmId);
  }

  /// 获取选中的奶厅 ID
  static String? getSelectedFarmId() {
    return _prefs?.getString('selected_farm_id');
  }

  /// 保存用户信息
  static Future<void> saveUserInfo(String name, String department) async {
    await _prefs?.setString('user_name', name);
    await _prefs?.setString('user_department', department);
  }

  /// 获取用户信息
  static ({String name, String department})? getUserInfo() {
    final name = _prefs?.getString('user_name');
    final department = _prefs?.getString('user_department');
    if (name == null || department == null) return null;
    return (name: name, department: department);
  }

  /// 清除所有数据
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
