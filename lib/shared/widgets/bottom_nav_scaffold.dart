import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 底部导航脚手架
/// 根据 URL 自动高亮当前 Tab
class BottomNavScaffold extends StatelessWidget {
  final Widget child;

  const BottomNavScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/data')) return 1;
    if (location.startsWith('/records')) return 2;
    if (location.startsWith('/personal-center')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/data');
              break;
            case 2:
              context.go('/records');
              break;
            case 3:
              context.go('/personal-center');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '数据'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: '记录'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}