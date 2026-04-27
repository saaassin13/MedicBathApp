import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/personal_center_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_personal_center_repository.dart';

/// Personal Center Repository Provider
final personalCenterRepositoryProvider = Provider<PersonalCenterRepository>((ref) {
  return MockPersonalCenterRepository();
});

/// 用户信息 Provider
final userInfoProvider = FutureProvider<UserInfo>((ref) async {
  final repository = ref.watch(personalCenterRepositoryProvider);
  return repository.getUserInfo();
});

/// 业务入口列表 Provider
final businessEntriesProvider = Provider<List<EntryItem>>((ref) {
  final repository = ref.watch(personalCenterRepositoryProvider);
  return repository.getBusinessEntries();
});

/// 系统入口列表 Provider
final systemEntriesProvider = Provider<List<EntryItem>>((ref) {
  final repository = ref.watch(personalCenterRepositoryProvider);
  return repository.getSystemEntries();
});
