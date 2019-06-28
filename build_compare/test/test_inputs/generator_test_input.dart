import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@BuildCompare()
@ShouldThrow(
  'Generator cannot target `notAClass`. `@BuildCompare` can only be applied to '
  'a class.',
  todo: 'Remove the `@BuildCompare` annotation from `notAClass`.',
)
const notAClass = 42;

@BuildCompare(equals: false, getHashCode: false)
@ShouldThrow(
  'All options are disabled on the @BuildCompare annotation.',
  todo: 'Make sure one of the options is set to `true`.',
)
class AllDisabled {
  String someField;
}

@ShouldThrow(
  'The class has no fields.',
  todo: 'Remove the `@BuildCompare` annotation or add a field.',
)
@BuildCompare()
class EmptyClass {}

@ShouldThrow(
  'None of the fields implement `Comparable`.',
  todo: 'Set `@BuildCompare(comparable: false)` or ensure there is a least one '
      'comparable field.',
)
@BuildCompare(compareTo: true)
class NoComparableField {
  Object notComparable;
}
