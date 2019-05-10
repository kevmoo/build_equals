part 'example.g.dart';

class Person implements Comparable<Person> {
  final String firstName;
  final String lastName;
  final int orderCount;
  final DateTime lastOrder;

  Person({
    this.firstName,
    this.lastName,
    this.orderCount,
    this.lastOrder,
  });

  @override
  bool operator ==(other) => _$PersonEquals(this, other);

  @override
  int get hashCode => _$PersonHashCode(this);

  @override
  int compareTo(Person other) => _$PersonCompare(this, other);
}
