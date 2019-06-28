import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'samples.g.dart';

@BuildCompare(compareTo: true)
class OneFieldClass with _$OneFieldClassCompare {
  @override
  int value;
}

@BuildCompare(compareTo: true, equals: false, getHashCode: false)
class OneFieldCompareOnlyClass with _$OneFieldCompareOnlyClassCompare {
  @override
  String name;

  @BuildCompareField(compareTo: false)
  String otherField;
}

@BuildCompare(compareTo: true)
class ExcludeFields with _$ExcludeFieldsCompare {
  @override
  String everything;

  @override
  @BuildCompareField(compareTo: false)
  String noCompare;

  @override
  @BuildCompareField(equalsAndHashCode: false)
  String noEqualsHash;

  @BuildCompareField(compareTo: false, equalsAndHashCode: false)
  String nothing;
}
