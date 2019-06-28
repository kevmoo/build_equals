// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samples.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

mixin _$OneFieldClassCompare implements Comparable<OneFieldClass> {
  int get value;

  @override
  bool operator ==(Object other) =>
      other is OneFieldClass && value == other.value;

  @override
  int get hashCode {
    var hash = 0;
    hash = $buildCompareHashCombine(hash, value.hashCode);
    return $buildCompareHashFinish(hash);
  }

  @override
  int compareTo(OneFieldClass other) =>
      $buildCompareNullSafeCompare(value, other.value);
}

mixin _$OneFieldCompareOnlyClassCompare
    implements Comparable<OneFieldCompareOnlyClass> {
  String get name;

  @override
  int compareTo(OneFieldCompareOnlyClass other) =>
      $buildCompareNullSafeCompare(name, other.name);
}

mixin _$ExcludeFieldsCompare implements Comparable<ExcludeFields> {
  String get everything;

  String get noCompare;

  String get noEqualsHash;

  @override
  bool operator ==(Object other) =>
      other is ExcludeFields &&
      everything == other.everything &&
      noCompare == other.noCompare;

  @override
  int get hashCode {
    var hash = 0;
    hash = $buildCompareHashCombine(hash, everything.hashCode);
    hash = $buildCompareHashCombine(hash, noCompare.hashCode);
    return $buildCompareHashFinish(hash);
  }

  @override
  int compareTo(ExcludeFields other) {
    var value = $buildCompareNullSafeCompare(everything, other.everything);
    if (value == 0) {
      value = $buildCompareNullSafeCompare(noEqualsHash, other.noEqualsHash);
    }
    return value;
  }
}
