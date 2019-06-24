import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'util.dart';

BuildCompare buildCompareFromConstantReader(ConstantReader annotation) =>
    BuildCompare(
      getHashCode: annotation.read('getHashCode').boolValue,
      equals: annotation.read('equals').boolValue,
      compareTo: annotation.read('compareTo').boolValue,
    );

List<FieldData> things(ClassElement classElement) {
  final fieldsList = createSortedFieldSet(classElement);
  return fieldsList.map(FieldData.fromElement).toList(growable: false);
}

class FieldData {
  final BuildCompareField annotation;
  final FieldElement field;

  String get name => field.name;

  DartType get type => field.type;

  FieldData(this.field, this.annotation);

  static FieldData fromElement(FieldElement element) {
    final obj = _buildCompareFieldChecker.firstAnnotationOfExact(element);
    final reader = ConstantReader(obj);

    BuildCompareField bcf;
    if (reader.isNull) {
      bcf = const BuildCompareField(compareTo: true, equalsAndHashCode: true);
    } else {
      final equalsAndHashCodeReader = reader.read('equalsAndHashCode');

      bcf = BuildCompareField(
        compareTo: reader.read('compareTo').literalValue ?? true,
        equalsAndHashCode: (equalsAndHashCodeReader.isNull
                ? null
                : equalsAndHashCodeReader.boolValue) ??
            false,
      );
    }

    return FieldData(element, bcf);
  }
}

const _buildCompareFieldChecker = TypeChecker.fromRuntime(BuildCompareField);
