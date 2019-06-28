import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  r'''
mixin _$EmptyClassCompare {
  @override
  bool operator ==(Object other) => other is EmptyClass;

  @override
  int get hashCode => 0;
}
''',
)
@BuildCompare()
class EmptyClass {}

@ShouldGenerate(
  r'''
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
''',
)
@BuildCompare(compareTo: true)
class OneFieldClass {
  int value;
}

@ShouldGenerate(
  r'''
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
''',
)
@BuildCompare(compareTo: true)
class VagueFieldClass {
  Object objectValue;

  dynamic dynamicValue;
}

@ShouldGenerate(
  r'''
mixin _$OneFieldCompareOnlyClassCompare
    implements Comparable<OneFieldCompareOnlyClass> {
  String get name;

  @override
  int compareTo(OneFieldCompareOnlyClass other) =>
      $buildCompareNullSafeCompare(name, other.name);
}
''',
)
@BuildCompare(compareTo: true, equals: false, getHashCode: false)
class OneFieldCompareOnlyClass {
  String name;

  @BuildCompareField(compareTo: false)
  String otherField;
}

@ShouldGenerate(
  r'''
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
''',
)
@BuildCompare(compareTo: true)
class ExcludeFields {
  String everything;

  @BuildCompareField(compareTo: false)
  String noCompare;

  @BuildCompareField(equalsAndHashCode: false)
  String noEqualsHash;

  @BuildCompareField(compareTo: false, equalsAndHashCode: false)
  String nothing;
}
