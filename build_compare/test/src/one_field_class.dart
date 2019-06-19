import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'one_field_class.g.dart';

@BuildCompare()
class OneFieldClass implements Comparable<OneFieldClass> {
  int value;

  @override
  bool operator ==(other) => _$OneFieldClassEquals(this, other);

  @override
  int get hashCode => _$OneFieldClassHashCode(this);

  @override
  int compareTo(OneFieldClass other) => _$OneFieldClassCompare(this, other);
}
