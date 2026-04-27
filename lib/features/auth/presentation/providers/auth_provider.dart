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