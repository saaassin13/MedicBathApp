import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairy_cow_teat_dipping/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DairyCowTeatDippingApp(),
      ),
    );

    // 验证应用可以正常构建
    expect(find.text('奶牛药浴大数据管理中心'), findsOneWidget);
  });
}