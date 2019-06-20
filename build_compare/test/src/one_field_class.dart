import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'one_field_class.g.dart';

@BuildCompare()
class OneFieldClass with _$OneFieldClassCompare {
  @override
  int value;
}
