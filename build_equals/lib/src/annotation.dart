import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_equals_annotation/build_equals_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'util.dart';

BuildEquals buildEqualsFromConstantReader(ConstantReader annotation) =>
    BuildEquals(
      getHashCode: annotation.read('getHashCode').boolValue,
      equals: annotation.read('equals').boolValue,
      compareTo: annotation.read('compareTo').boolValue,
    );

List<FieldData> fieldDataForClass(ClassElement classElement) {
  final fieldsList = createSortedFieldSet(classElement);
  return fieldsList.map(FieldData.fromElement).toList(growable: false);
}

class FieldData {
  final BuildEqualsField annotation;
  final FieldElement field;

  String get name => field.name;

  DartType get type => field.type;

  FieldData(this.field, this.annotation);

  static FieldData fromElement(FieldElement element) {
    final obj = _buildEqualsFieldChecker.firstAnnotationOfExact(element);
    final reader = ConstantReader(obj);

    BuildEqualsField bcf;
    if (reader.isNull) {
      bcf = const BuildEqualsField(compareTo: true, equalsAndHashCode: true);
    } else {
      final equalsAndHashCodeReader = reader.read('equalsAndHashCode');

      bcf = BuildEqualsField(
        compareTo: reader.read('compareTo').literalValue ?? true,
        equalsAndHashCode: (equalsAndHashCodeReader.isNull
                ? null
                : equalsAndHashCodeReader.boolValue) ??
            true,
      );
    }

    return FieldData(element, bcf);
  }
}

const _buildEqualsFieldChecker = TypeChecker.fromRuntime(BuildEqualsField);
