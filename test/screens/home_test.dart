import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter_app/models/favorites.dart';
import 'package:testing_flutter_app/screens/home.dart';

Widget createHomeWidget() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('home widget test', () {
    testWidgets('testing scrolling', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeWidget());
      expect(find.text('Item 0'), findsOneWidget);
      await widgetTester.fling(
          find.byType(ListView), const Offset(0, -700), 3000);
      await widgetTester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });
    testWidgets('test icon button', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeWidget());
      expect(find.byIcon(Icons.favorite_border).first, findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
      await widgetTester.tap(find.byIcon(Icons.favorite_border).first);
      await widgetTester.pumpWidget(createHomeWidget());
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await widgetTester.tap(find.byIcon(Icons.favorite).first);
      await widgetTester.pumpWidget(createHomeWidget());
      expect(find.byIcon(Icons.favorite_border).first, findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
