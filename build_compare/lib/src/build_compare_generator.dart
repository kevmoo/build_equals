import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'constants.dart';
import 'util.dart';

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

    // Get all of the fields that need to be assigned
    // TODO: We only care about constructor things + writable fields, right?
    final fieldsList = createSortedFieldSet(classElement);

    final classBuffer = StringBuffer()
      ..writeln('mixin $_prefix${name}Compare implements Comparable<$name> {');

    for (var field in fieldsList) {
      classBuffer.writeln('${field.type} get ${field.name};\n');
    }

    yield* _writeEqualsAndHashCode(fieldsList, classBuffer, name);
    yield* _writeCompareTo(fieldsList, classBuffer, name);

    classBuffer.writeln('}');
    yield classBuffer.toString();
  }

  Iterable<String> _writeEqualsAndHashCode(
    Set<FieldElement> fieldsList,
    StringBuffer classBuffer,
    String name,
  ) sync* {
    // TODO: handle known, non-trivial cases: Iterable, Map, etc
    final equalsItems =
        fieldsList.map((e) => '&& ${e.name} == other.${e.name}');

    classBuffer.writeln('@override '
        'bool operator ==(Object other) => '
        'other is $name ${equalsItems.join()};\n');

    List<String> lines;

    if (fieldsList.isEmpty) {
      lines = ['return 0;'];
    } else {
      yield hashMembers;

      lines = [
        'var hash = 0;',
        ...fieldsList.map(
          (e) => 'hash = '
              '_buildCompareHashCombine(hash, ${e.name}.hashCode);',
        ),
        'return _buildCompareHashFinish(hash);',
      ];
    }

    classBuffer.writeln('@override int get hashCode '
        '${_expressionOrBlock(lines)}');
  }

  Iterable<String> _writeCompareTo(
    Set<FieldElement> fieldsList,
    StringBuffer classBuffer,
    String name,
  ) sync* {
    final comparableFields = fieldsList
        .where((fe) => _dartCoreComparableChecker.isAssignableFromType(fe.type))
        .toList(growable: false);

    List<String> lines;

    if (comparableFields.isEmpty) {
      lines = ['return 0;'];
    } else {
      yield nullSafeCompare;

      if (comparableFields.length == 1) {
        lines = [
          'return ${_nullSafeCompareCall(comparableFields.single.name)};'
        ];
      } else {
        lines = [
          'var value = ${_nullSafeCompareCall(comparableFields.first.name)};',
          for (var fieldName in comparableFields.skip(1).map((e) => e.name))
            '''
if (value == 0) {
  value = ${_nullSafeCompareCall(fieldName)};
}''',
          'return value;',
        ];
      }
    }

    classBuffer.writeln('@override int compareTo($name other) '
        '${_expressionOrBlock(lines)}');
  }
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

String _nullSafeCompareCall(String fieldName) =>
    '_buildCompareNullSafeCompare($fieldName, other.$fieldName)';

const _prefix = r'_$';

const _dartCoreComparableChecker = TypeChecker.fromUrl('dart:core#Comparable');
