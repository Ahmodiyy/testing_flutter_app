import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter_app/models/favorites.dart';
import 'package:testing_flutter_app/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('favorite widget test', () {
    testWidgets('test if listview shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpWidget(createFavoritesScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('testing remove button', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pump();
      int totalInitialCloseIcon =
          widgetTester.widgetList(find.byIcon(Icons.close)).length;
      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pump();
      expect(widgetTester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalInitialCloseIcon));
    });
  });
}
