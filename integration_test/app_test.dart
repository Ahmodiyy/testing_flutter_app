import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:testing_flutter_app/main.dart';

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding binding =
        IntegrationTestWidgetsFlutterBinding.ensureInitialized()
            as IntegrationTestWidgetsFlutterBinding;
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    final listFinder = find.byType(ListView);

    testWidgets('test scrolling', (widgetTester) async {
      await widgetTester.pumpWidget(TestingApp());

      binding.watchPerformance(() async {
        await widgetTester.fling(listFinder, Offset(0, -500), 10000);
        await widgetTester.pumpAndSettle();

        await widgetTester.fling(listFinder, Offset(0, 500), 10000);
        await widgetTester.pumpAndSettle();
      }, reportKey: 'scrolling summary');
    });
  });
}
