import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test('example', () {
    final emptyPerson1 = Person();
    _expectSame(emptyPerson1, emptyPerson1);

    final emptyPerson2 = Person();
    _expectSame(emptyPerson1, emptyPerson2);

    final allFieldsPerson = Person(
      firstName: 'firstName',
      lastName: 'lastName',
      lastOrder: DateTime.utc(1979),
      orderCount: 42,
    );

    _expectSame(allFieldsPerson, allFieldsPerson);

    _expectDifferent(emptyPerson1, allFieldsPerson);
  });
}

void _expectSame<T extends Comparable<T>>(T first, T second) {
  expect(first, equals(second));
  expect(first.hashCode, equals(second.hashCode));
  expect(first.compareTo(second), equals(0));
}

void _expectDifferent<T extends Comparable<T>>(T first, T second) {
  expect(first, isNot(equals(second)), reason: 'should not be equal');
  expect(
    first.hashCode,
    isNot(equals(second.hashCode)),
    reason: 'should have different hashCode values',
  );
  expect(
    first.compareTo(second),
    lessThan(0),
    reason: '`first` should come before `second`.',
  );
}
