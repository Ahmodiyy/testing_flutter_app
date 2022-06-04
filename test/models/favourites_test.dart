import 'package:test/test.dart';
import 'package:testing_flutter_app/models/favorites.dart';

void main() {
  group('test favorites object', () {
    var favorites = Favorites();
    test('test favorites add methods', () {
      var number = 20;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });
    test('test favorite remove meethod', () {
      var number = 80;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}
