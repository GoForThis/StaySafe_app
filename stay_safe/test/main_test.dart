import 'package:flutter_test/flutter_test.dart';
import 'package:stay_safe/main.dart';

void main() {
  group('MyAppState', () {
    test('getNext() should update the current word pair', () {
      final myAppState = MyAppState();
      final initialWordPair = myAppState.current;

      myAppState.getNext();

      expect(myAppState.current, isNot(equals(initialWordPair)));
    });

    test(
        'toggleFavourite() should add or remove the current word pair from favourites',
        () {
      final myAppState = MyAppState();
      final initialWordPair = myAppState.current;

      myAppState.toggleFavourite();
      expect(myAppState.favourites.contains(initialWordPair), isTrue);

      myAppState.toggleFavourite();
      expect(myAppState.favourites.contains(initialWordPair), isFalse);
    });
  });
}
