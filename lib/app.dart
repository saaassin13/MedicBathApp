import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class DairyCowTeatDippingApp extends StatelessWidget {
  const DairyCowTeatDippingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '奶牛药浴',
      theme: buildAppTheme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}