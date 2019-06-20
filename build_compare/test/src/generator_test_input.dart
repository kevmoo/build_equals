import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  r'''
mixin _$EmptyClassCompare implements Comparable<EmptyClass> {
  @override
  bool operator ==(Object other) => other is EmptyClass;

  @override
  int get hashCode => 0;

  @override
  int compareTo(EmptyClass other) => 0;
}
''',
)
@BuildCompare()
class EmptyClass {}

@ShouldGenerate(
  r'''
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

mixin _$OneFieldClassCompare implements Comparable<OneFieldClass> {
  int get value;

  @override
  bool operator ==(Object other) =>
      other is OneFieldClass && value == other.value;

  @override
  int get hashCode {
    var hash = 0;
    hash = _buildCompareHashCombine(hash, value.hashCode);
    return _buildCompareHashFinish(hash);
  }

  @override
  int compareTo(OneFieldClass other) =>
      _buildCompareNullSafeCompare(value, other.value);
}
''',
)
@BuildCompare()
class OneFieldClass {
  int value;
}

@ShouldGenerate(
  r'''
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

mixin _$VagueFieldClassCompare implements Comparable<VagueFieldClass> {
  Object get objectValue;

  dynamic get dynamicValue;

  @override
  bool operator ==(Object other) =>
      other is VagueFieldClass &&
      objectValue == other.objectValue &&
      dynamicValue == other.dynamicValue;

  @override
  int get hashCode {
    var hash = 0;
    hash = _buildCompareHashCombine(hash, objectValue.hashCode);
    hash = _buildCompareHashCombine(hash, dynamicValue.hashCode);
    return _buildCompareHashFinish(hash);
  }

  @override
  int compareTo(VagueFieldClass other) => 0;
}
''',
)
@BuildCompare()
class VagueFieldClass {
  Object objectValue;

  dynamic dynamicValue;
}
