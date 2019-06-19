// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

bool _$PersonEquals(Person instance, Object other) =>
    other is Person &&
    instance.firstName == other.firstName &&
    instance.lastName == other.lastName &&
    instance.orderCount == other.orderCount &&
    instance.lastOrder == other.lastOrder;

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

int _$PersonHashCode(Person instance) {
  var hash = 0;
  hash = _buildCompareHashCombine(hash, instance.firstName.hashCode);
  hash = _buildCompareHashCombine(hash, instance.lastName.hashCode);
  hash = _buildCompareHashCombine(hash, instance.orderCount.hashCode);
  hash = _buildCompareHashCombine(hash, instance.lastOrder.hashCode);
  return _buildCompareHashFinish(hash);
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

int _$PersonCompare(Person a, Person b) {
  var value = _buildCompareNullSafeCompare(a.firstName, b.firstName);
  if (value == 0) {
    value = _buildCompareNullSafeCompare(a.lastName, b.lastName);
  }
  if (value == 0) {
    value = _buildCompareNullSafeCompare(a.orderCount, b.orderCount);
  }
  if (value == 0) {
    value = _buildCompareNullSafeCompare(a.lastOrder, b.lastOrder);
  }
  return value;
}
