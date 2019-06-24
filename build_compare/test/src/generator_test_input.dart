import 'package:build_compare/src/constants.dart';
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
  '''
$hashMembers
$nullSafeCompare
mixin _\$OneFieldClassCompare implements Comparable<OneFieldClass> {
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
  '''
$hashMembers
mixin _\$VagueFieldClassCompare implements Comparable<VagueFieldClass> {
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

@ShouldGenerate(
  '''
$hashMembers
$nullSafeCompare
mixin _\$OneFieldCompareOnlyClassCompare
    implements Comparable<OneFieldCompareOnlyClass> {
  String get name;

  String get otherField;

  @override
  bool operator ==(Object other) =>
      other is OneFieldCompareOnlyClass &&
      name == other.name &&
      otherField == other.otherField;

  @override
  int get hashCode {
    var hash = 0;
    hash = _buildCompareHashCombine(hash, name.hashCode);
    hash = _buildCompareHashCombine(hash, otherField.hashCode);
    return _buildCompareHashFinish(hash);
  }

  @override
  int compareTo(OneFieldCompareOnlyClass other) {
    var value = _buildCompareNullSafeCompare(name, other.name);
    if (value == 0) {
      value = _buildCompareNullSafeCompare(otherField, other.otherField);
    }
    return value;
  }
}
''',
)
@BuildCompare(compareTo: true, equals: false, getHashCode: false)
class OneFieldCompareOnlyClass {
  String name;

  @BuildCompareField(compareTo: false)
  String otherField;
}
