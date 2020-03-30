// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samples.dart';

// **************************************************************************
// BuildEqualsGenerator
// **************************************************************************

mixin _$OneFieldClassCompare implements Comparable<OneFieldClass> {
  int get value;

  @override
  bool operator ==(Object other) =>
      other is OneFieldClass && value == other.value;

  @override
  int get hashCode {
    var hash = 0;
    hash = $buildEqualsHashCombine(hash, value.hashCode);
    return $buildEqualsHashFinish(hash);
  }

  @override
  int compareTo(OneFieldClass other) =>
      $buildEqualsNullSafeCompare(value, other.value);
}

mixin _$OneFieldCompareOnlyClassCompare
    implements Comparable<OneFieldCompareOnlyClass> {
  String get name;

  @override
  int compareTo(OneFieldCompareOnlyClass other) =>
      $buildEqualsNullSafeCompare(name, other.name);
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
    hash = $buildEqualsHashCombine(hash, everything.hashCode);
    hash = $buildEqualsHashCombine(hash, noCompare.hashCode);
    return $buildEqualsHashFinish(hash);
  }

  @override
  int compareTo(ExcludeFields other) {
    var value = $buildEqualsNullSafeCompare(everything, other.everything);
    if (value == 0) {
      value = $buildEqualsNullSafeCompare(noEqualsHash, other.noEqualsHash);
    }
    return value;
  }
}
