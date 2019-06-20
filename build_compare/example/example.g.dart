// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

int _buildCompareHashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _buildCompareHashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

/// Handles comparing [a] and [b] if one or both of them are `null`.
///
/// If both values are `null`, `0` is returned.
/// If one value is `null`, it is sorted first.
/// If neither value is `null`, `a.compareTo(b)` is returned.
int _buildCompareNullSafeCompare(Comparable a, Comparable b) {
  if (a == null) {
    if (b == null) {
      return 0;
    }
    return -1;
  } else if (b == null) {
    return 1;
  }
  return a.compareTo(b);
}

mixin _$PersonCompare implements Comparable<Person> {
  String get firstName;

  String get lastName;

  int get orderCount;

  DateTime get lastOrder;

  @override
  bool operator ==(Object other) =>
      other is Person &&
      firstName == other.firstName &&
      lastName == other.lastName &&
      orderCount == other.orderCount &&
      lastOrder == other.lastOrder;

  @override
  int get hashCode {
    var hash = 0;
    hash = _buildCompareHashCombine(hash, firstName.hashCode);
    hash = _buildCompareHashCombine(hash, lastName.hashCode);
    hash = _buildCompareHashCombine(hash, orderCount.hashCode);
    hash = _buildCompareHashCombine(hash, lastOrder.hashCode);
    return _buildCompareHashFinish(hash);
  }

  @override
  int compareTo(Person other) {
    var value = _buildCompareNullSafeCompare(firstName, other.firstName);
    if (value == 0) {
      value = _buildCompareNullSafeCompare(lastName, other.lastName);
    }
    if (value == 0) {
      value = _buildCompareNullSafeCompare(orderCount, other.orderCount);
    }
    if (value == 0) {
      value = _buildCompareNullSafeCompare(lastOrder, other.lastOrder);
    }
    return value;
  }
}
