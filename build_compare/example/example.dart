import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'example.g.dart';

@BuildCompare()
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
