import 'package:build_equals_annotation/build_equals_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@BuildEquals()
@ShouldThrow(
  'Generator cannot target `notAClass`. `@BuildEquals` can only be applied to '
  'a class.',
  todo: 'Remove the `@BuildEquals` annotation from `notAClass`.',
)
const notAClass = 42;

@BuildEquals(equals: false, getHashCode: false)
@ShouldThrow(
  'All options are disabled on the @BuildEquals annotation.',
  todo: 'Make sure one of the options is set to `true`.',
)
class AllDisabled {
  String someField;
}

@ShouldThrow(
  'The class has no fields.',
  todo: 'Remove the `@BuildEquals` annotation or add a field.',
)
@BuildEquals()
class EmptyClass {}

@ShouldThrow(
  'None of the fields implement `Comparable`.',
  todo: 'Set `@BuildEquals(comparable: false)` or ensure there is a least one '
      'comparable field.',
)
@BuildEquals(compareTo: true)
class NoComparableField {
  Object notComparable;
}
