// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// BuildEqualsGenerator
// **************************************************************************

mixin _$PersonCompare implements Comparable<Person> {
  String get firstName;

  String get lastName;

  int get orderCount;

  DateTime get lastOrder;

  List<int> get luckyNumbers;

  @override
  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      lastName == other.lastName &&
      orderCount == other.orderCount &&
      lastOrder == other.lastOrder &&
      $buildEqualsDeepEquals(luckyNumbers, other.luckyNumbers);

  @override
  int get hashCode {
    var hash = 0;
    hash = $buildEqualsHashCombine(hash, firstName.hashCode);
    hash = $buildEqualsHashCombine(hash, lastName.hashCode);
    hash = $buildEqualsHashCombine(hash, orderCount.hashCode);
    hash = $buildEqualsHashCombine(hash, lastOrder.hashCode);
    hash = $buildEqualsHashCombine(hash, $buildEqualsDeepHash(luckyNumbers));
    return $buildEqualsHashFinish(hash);
  }

  @override
  int compareTo(Person other) {
    var value = $buildEqualsNullSafeCompare(firstName, other.firstName);
    if (value == 0) {
      value = $buildEqualsNullSafeCompare(lastName, other.lastName);
    }
    if (value == 0) {
      value = $buildEqualsNullSafeCompare(orderCount, other.orderCount);
    }
    if (value == 0) {
      value = $buildEqualsNullSafeCompare(lastOrder, other.lastOrder);
    }
    return value;
  }
}
