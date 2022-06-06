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
    testWidgets('favorite operation test', (widgetTester) async {
      await widgetTester.pumpWidget(TestingApp());
      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];
      for (var icon in iconKeys) {
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(Duration(seconds: 1));
        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await widgetTester.tap(find.text('Favorites'));
      await widgetTester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (var icon in removeIconKeys) {
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(Duration(seconds: 1));
        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });
}
