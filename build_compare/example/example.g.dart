part of 'example.dart';

bool _$PersonEquals(Person instance, Object other) =>
    other is Person && instance.firstName == other.firstName;

int _$PersonHashCode(Person instance) => instance.firstName.hashCode;

int _$PersonCompare(Person a, Person b) =>
    _nullSafeCompare(a.firstName, b.firstName);

/// Handles comparing [a] and [b] if one or both of them are `null`.
///
/// If both values are `null`, `0` is returned.
/// If one value is `null`, it is sorted first.
/// If neither value is `null`, `a.compareTo(b)` is returned.
int _nullSafeCompare<T extends Comparable<T>>(T a, T b) {
  if (a == null) {
    if (b == null) {
      return 0;
    }
    return -1;
  } else if (b == null) {
    return 1;
  }
  return a.compareTo(b);
}
