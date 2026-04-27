import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/home_repository.dart';
import '../../domain/entities.dart';
import '../../data/mock_home_repository.dart';

/// Home Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return MockHomeRepository();
});

/// 首页数据 Provider
final homePageDataProvider = FutureProvider<HomePageData>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getHomePageData();
});
