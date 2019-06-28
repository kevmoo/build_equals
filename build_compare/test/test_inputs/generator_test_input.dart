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
