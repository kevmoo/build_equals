// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// BuildCompareGenerator
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
      $buildCompareDeepEquals(luckyNumbers, other.luckyNumbers);

  @override
  int get hashCode {
    var hash = 0;
    hash = $buildCompareHashCombine(hash, firstName.hashCode);
    hash = $buildCompareHashCombine(hash, lastName.hashCode);
    hash = $buildCompareHashCombine(hash, orderCount.hashCode);
    hash = $buildCompareHashCombine(hash, lastOrder.hashCode);
    hash = $buildCompareHashCombine(hash, $buildCompareDeepHash(luckyNumbers));
    return $buildCompareHashFinish(hash);
  }

  @override
  int compareTo(Person other) {
    var value = $buildCompareNullSafeCompare(firstName, other.firstName);
    if (value == 0) {
      value = $buildCompareNullSafeCompare(lastName, other.lastName);
    }
    if (value == 0) {
      value = $buildCompareNullSafeCompare(orderCount, other.orderCount);
    }
    if (value == 0) {
      value = $buildCompareNullSafeCompare(lastOrder, other.lastOrder);
    }
    return value;
  }
}
