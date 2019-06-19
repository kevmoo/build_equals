// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_field_class.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

bool _$OneFieldClassEquals(OneFieldClass instance, Object other) =>
    other is OneFieldClass && instance.value == other.value;

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

int _$OneFieldClassHashCode(OneFieldClass instance) {
  var hash = 0;
  hash = _buildCompareHashCombine(hash, instance.value.hashCode);
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

int _$OneFieldClassCompare(OneFieldClass a, OneFieldClass b) =>
    _buildCompareNullSafeCompare(a.value, b.value);
