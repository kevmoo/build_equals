import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'empty_class.g.dart';

@BuildCompare()
class EmptyClass implements Comparable<EmptyClass> {
  @override
  bool operator ==(other) => _$EmptyClassEquals(this, other);

  @override
  int get hashCode => _$EmptyClassHashCode(this);

  @override
  int compareTo(EmptyClass other) => _$EmptyClassCompare(this, other);
}
