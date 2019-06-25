import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'example.g.dart';

@BuildCompare(compareTo: true)
class Person with _$PersonCompare {
  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final int orderCount;

  @override
  final DateTime lastOrder;

  Person({
    this.firstName,
    this.lastName,
    this.orderCount,
    this.lastOrder,
  });
}
