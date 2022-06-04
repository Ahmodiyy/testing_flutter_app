import 'package:flutter/cupertino.dart';
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
  });
}
