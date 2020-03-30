import 'package:build_equals_annotation/build_equals_annotation.dart';

part 'example.g.dart';

@BuildEquals(compareTo: true)
class Person with _$PersonCompare {
  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final int orderCount;

  @override
  final DateTime lastOrder;

  @override
  final List<int> luckyNumbers;

  Person({
    this.firstName,
    this.lastName,
    this.orderCount,
    this.lastOrder,
    this.luckyNumbers,
  });
}
