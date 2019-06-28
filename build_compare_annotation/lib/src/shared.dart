import 'package:collection/collection.dart';

bool $buildCompareDeepEquals(Object a, Object b) =>
    const DeepCollectionEquality().equals(a, b);

int $buildCompareDeepHash(Object a) => const DeepCollectionEquality().hash(a);
