// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samples.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

mixin _$EmptyClassCompare {
  @override
  bool operator ==(Object other) => other is EmptyClass;

  @override
  int get hashCode => 0;
}

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
    hash = $buildCompareHashCombine(hash, objectValue.hashCode);
    hash = $buildCompareHashCombine(hash, dynamicValue.hashCode);
    return $buildCompareHashFinish(hash);
  }

  @override
  int compareTo(VagueFieldClass other) => 0;
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
