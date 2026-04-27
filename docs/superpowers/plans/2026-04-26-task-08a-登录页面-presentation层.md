# Task 8a: 认证模块 - 登录页面 Presentation 层

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建登录页面的 Presentation 层，包含页面 UI 和状态管理

**Architecture:** 认证模块 presentation 层，Riverpod 状态管理

**Tech Stack:** Riverpod Notifier, GoRouter, LoginPage

**前置任务:** Task 6 (Auth Domain), Task 7 (Auth Data)

**依赖文件:**
- `lib/features/auth/presentation/providers/auth_provider.dart` (由 Task 8b 创建)
- `lib/features/auth/domain/user.dart` (Task 6)
- `lib/features/auth/domain/farm.dart` (Task 6)

---

## Files

- Create: `lib/features/auth/presentation/providers/auth_provider.dart`
- Create: `lib/features/auth/presentation/pages/login_page.dart`

---

## Step by Step

- [x] **Step 1: 创建 auth_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/auth_repository.dart';
import '../../domain/user.dart';
import '../../domain/farm.dart';
import '../../data/mock_auth_repository.dart';

/// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

/// 登录状态
enum AuthStatus { initial, loading, success, failure }

/// Auth 状态
class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final user = await _repository.login(username, password);
      state = state.copyWith(status: AuthStatus.success, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState();
  }
}

/// Auth Notifier Provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// 奶厅列表 Provider (供选择奶厅页面使用)
final farmsProvider = FutureProvider((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getFarms();
});

/// 搜索关键字 Provider
final farmSearchProvider = StateProvider<String>((ref) => '');

/// 过滤后的奶厅列表 Provider
final filteredFarmsProvider = Provider<AsyncValue<List<Farm>>>((ref) {
  final farmsAsync = ref.watch(farmsProvider);
  final searchKeyword = ref.watch(farmSearchProvider).toLowerCase();

  return farmsAsync.whenData((farms) {
    if (searchKeyword.isEmpty) return farms;
    return farms.where((farm) =>
      farm.name.toLowerCase().contains(searchKeyword) ||
      farm.farmName.toLowerCase().contains(searchKeyword)
    ).toList();
  });
});
```

- [x] **Step 2: 创建 login_page.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreePrivacy = false; // 隐私政策勾选状态

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    // 检查隐私政策勾选
    if (!_agreePrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请阅读并同意隐私保护政策')),
      );
      return;
    }

    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入用户名和密码')),
      );
      return;
    }

    await ref.read(authNotifierProvider.notifier).login(username, password);
  }

  void _showPrivacyPolicy() {
    // 显示隐私政策页面或弹窗
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('隐私保护政策'),
        content: const SingleChildScrollView(
          child: Text('这里是隐私保护政策的详细内容...\n\n'
              '我们收集您的账号信息以便进行用户认证。\n'
              '您的数据将根据隐私政策进行保护。'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.success) {
        context.go('/select-farm');
      } else if (next.status == AuthStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? '登录失败')),
        );
      }
    });

    // 检查是否满足登录条件
    final canLogin = _usernameController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _agreePrivacy;

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo 区域
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.agriculture,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Scaling Robotics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryOrange,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '奶牛药浴大数据管理中心',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 48),
              // 用户名输入框
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: '请输入账号',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryOrange),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              // 密码输入框
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primaryOrange),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              // 登录按钮
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: canLogin ? _onLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    disabledBackgroundColor: AppColors.primaryOrange.withOpacity(0.5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: authState.status == AuthStatus.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          '登录',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // 隐私政策勾选
              Row(
                children: [
                  Checkbox(
                    value: _agreePrivacy,
                    onChanged: (value) => setState(() => _agreePrivacy = value ?? false),
                    activeColor: AppColors.primaryOrange,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: _showPrivacyPolicy,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          children: [
                            const TextSpan(text: '登录代表阅读并同意'),
                            TextSpan(
                              text: '《隐私保护政策》',
                              style: const TextStyle(color: AppColors.primaryOrange),
                            ),
                            const TextSpan(text: '和'),
                            TextSpan(
                              text: '《用户协议》',
                              style: const TextStyle(color: AppColors.primaryOrange),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

> **注意**：登录按钮在未填写完整或未勾选隐私政策时禁用显示。

> **依赖说明**：auth_provider.dart 在 Step 1 中创建，包含了 AuthNotifier、AuthStatus、AuthState 以及奶厅列表相关 Provider。

---

## Verification

- [x] 登录页面显示用户名/密码输入框和登录按钮
- [x] 登录按钮在未填写完整或未勾选隐私政策时禁用显示
- [x] 隐私政策链接可点击，弹出政策详情
- [x] 登录成功后跳转到选择奶厅页面

---

## 后续任务

- Task 8b: 选择奶厅页面 (select_farm_page.dart)
