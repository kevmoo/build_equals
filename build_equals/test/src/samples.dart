import 'package:build_equals_annotation/build_equals_annotation.dart';

part 'samples.g.dart';

@BuildEquals(compareTo: true)
class OneFieldClass with _$OneFieldClassCompare {
  @override
  int value;
}

@BuildEquals(compareTo: true, equals: false, getHashCode: false)
class OneFieldCompareOnlyClass with _$OneFieldCompareOnlyClassCompare {
  @override
  String name;

  @BuildEqualsField(compareTo: false)
  String otherField;
}

@BuildEquals(compareTo: true)
class ExcludeFields with _$ExcludeFieldsCompare {
  @override
  String everything;

  @override
  @BuildEqualsField(compareTo: false)
  String noCompare;

  @override
  @BuildEqualsField(equalsAndHashCode: false)
  String noEqualsHash;

  @BuildEqualsField(compareTo: false, equalsAndHashCode: false)
  String nothing;
}
