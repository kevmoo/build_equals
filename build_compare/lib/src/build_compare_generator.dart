import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation.dart';

/// A `package:source_gen` `Generator` which generates CLI parsing code
/// for classes annotated with [BuildCompare].
///
/// Developers shouldn't need to access this class directly unless they are
/// configuring a `package:source_gen` `PartBuilder` in code.
class BuildCompareGenerator extends GeneratorForAnnotation<BuildCompare> {
  const BuildCompareGenerator();

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    final name = element.displayName;
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `$name`. '
        '`@BuildCompare` can only be applied to a class.',
        todo: 'Remove the `@BuildCompare` annotation from `$name`.',
        element: element,
      );
    }

    final classElement = element as ClassElement;

    final classAnnotation = buildCompareFromConstantReader(annotation);

    final oneEnabled = classAnnotation.getHashCode ||
        classAnnotation.compareTo ||
        classAnnotation.equals;
    if (!oneEnabled) {
      throw InvalidGenerationSourceError(
        'All options are disabled on the @BuildCompare annotation.',
        todo: 'Make sure one of the options is set to `true`.',
        element: element,
      );
    }

    final fieldsList = fieldDataForClass(classElement);
    if (fieldsList.isEmpty) {
      throw InvalidGenerationSourceError(
        'The class has no fields.',
        todo: 'Remove the `@BuildCompare` annotation or add a field.',
        element: element,
      );
    }

    final usedFields = <FieldData>{};

    final functionBuffer = StringBuffer();

    final equalsAndHashFields = fieldsList
        .where((fd) => fd.annotation.equalsAndHashCode)
        .toList(growable: false);

    if (classAnnotation.equals || classAnnotation.getHashCode) {
      usedFields.addAll(equalsAndHashFields);
    }

    if (classAnnotation.equals) {
      final equalsItems =
          equalsAndHashFields.map((e) => '&& ${_equalsForFieldData(e)}');

      functionBuffer.writeln('@override '
          'bool operator ==(Object other) => '
          'other is $name ${equalsItems.join()};\n');
    }

    if (classAnnotation.getHashCode) {
      functionBuffer
          .writeln(_writeEqualsAndHashCode(equalsAndHashFields, name));
    }

    if (classAnnotation.compareTo) {
      final comparableFields = fieldsList
          .where((fe) =>
              _dartCoreComparableChecker.isAssignableFromType(fe.type) &&
              fe.annotation.compareTo != false)
          .toList(growable: false);

      if (comparableFields.isEmpty) {
        throw InvalidGenerationSourceError(
          'None of the fields implement `Comparable`.',
          todo: 'Set `@BuildCompare(comparable: false)` or ensure there is a '
              'least one comparable field.',
          element: element,
        );
      }

      usedFields.addAll(comparableFields);

      List<String> lines;

      if (comparableFields.length == 1) {
        lines = ['return ${_nullSafeCompareCall(comparableFields.single)};'];
      } else {
        lines = [
          'var value = ${_nullSafeCompareCall(comparableFields.first)};',
          for (var fieldData in comparableFields.skip(1))
            '''
if (value == 0) {
  value = ${_nullSafeCompareCall(fieldData)};
}''',
          'return value;',
        ];
      }

      functionBuffer.writeln('@override int compareTo($name other) '
          '${_expressionOrBlock(lines)}');
    }

    final classBuffer = StringBuffer()..write('mixin $_prefix${name}Compare ');
    if (classAnnotation.compareTo) {
      classBuffer.write('implements Comparable<$name> ');
    }
    classBuffer.writeln('{');

    for (var field in usedFields) {
      classBuffer.writeln('${field.type} get ${field.name};\n');
    }

    classBuffer..writeln(functionBuffer)..writeln('}');
    yield classBuffer.toString();
  }
}

String _writeEqualsAndHashCode(
  Iterable<FieldData> fieldsList,
  String name,
) {
  List<String> lines;

  if (fieldsList.isEmpty) {
    lines = ['return 0;'];
  } else {
    lines = [
      'var hash = 0;',
      ...fieldsList.map(
        (e) => 'hash = '
            '\$buildCompareHashCombine(hash, ${_hashCodeForFieldData(e)});',
      ),
      'return \$buildCompareHashFinish(hash);',
    ];
  }

  return '@override\nint get hashCode ${_expressionOrBlock(lines)}';
}

String _equalsForFieldData(FieldData data) {
  if (_dartCollectionChecker.isAssignableFromType(data.type)) {
    return '\$buildCompareDeepEquals(${data.name}, other.${data.name})';
  }
  return '${data.name} == other.${data.name}';
}

String _hashCodeForFieldData(FieldData data) {
  if (_dartCollectionChecker.isAssignableFromType(data.type)) {
    return '\$buildCompareDeepHash(${data.name})';
  }
  return '${data.name}.hashCode';
}

String _expressionOrBlock(List<String> lines) {
  assert(lines.isNotEmpty);
  const returnPrefix = 'return ';
  assert(lines.last.startsWith(returnPrefix));

  if (lines.length > 1) {
    return '''
{
  ${lines.join('\n  ')}
}
''';
  }

  return '=> ${lines.single.substring(returnPrefix.length)}\n';
}

String _nullSafeCompareCall(FieldData data) {
  final fieldName = data.name;
  return '\$buildCompareNullSafeCompare($fieldName, other.$fieldName)';
}

const _prefix = r'_$';

const _dartCoreComparableChecker = TypeChecker.fromUrl('dart:core#Comparable');

const _dartCollectionChecker = TypeChecker.any([
  TypeChecker.fromUrl('dart:core#Iterable'),
  TypeChecker.fromUrl('dart:core#Map'),
]);
