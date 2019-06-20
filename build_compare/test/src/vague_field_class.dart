import 'package:build_compare_annotation/build_compare_annotation.dart';

part 'vague_field_class.g.dart';

@BuildCompare()
class VagueFieldClass with _$VagueFieldClassCompare {
  @override
  Object objectValue;

  @override
  dynamic dynamicValue;
}
