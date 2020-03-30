import 'package:collection/collection.dart';

bool $buildEqualsDeepEquals(Object a, Object b) =>
    const DeepCollectionEquality().equals(a, b);

int $buildEqualsDeepHash(Object a) => const DeepCollectionEquality().hash(a);

int $buildEqualsHashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int $buildEqualsHashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

/// Handles comparing [a] and [b] if one or both of them are `null`.
///
/// If both values are `null`, `0` is returned.
/// If one value is `null`, it is sorted first.
/// If neither value is `null`, `a.compareTo(b)` is returned.
int $buildEqualsNullSafeCompare(Comparable a, Comparable b) {
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
