import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_compare_annotation/build_compare_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'util.dart';

/// A `package:source_gen` `Generator` which generates CLI parsing code
/// for classes annotated with [BuildCompare].
///
/// Developers shouldn't need to access this class directly unless they are
/// configuring a `package:source_gen` `PartBuilder` in code.
class BuildCompareGenerator extends GeneratorForAnnotation<BuildCompare> {
  const BuildCompareGenerator();

  @override
  Stream<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async* {
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

    {
      // TODO: handle known, non-trivial cases: Iterable, Map, etc
      final equalsItems =
          fieldsList.map((e) => '&& ${e.name} == other.${e.name}');

      classBuffer.writeln('@override '
          'bool operator ==(Object other) => '
          'other is $name ${equalsItems.join()};\n');
    }

    {
      List<String> lines;

      if (fieldsList.isEmpty) {
        lines = ['return 0;'];
      } else {
        yield _hashMembers;

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

    {
      List<String> lines;

      if (fieldsList.isEmpty) {
        lines = ['return 0;'];
      } else {
        yield _nullSafeCompare;

        if (fieldsList.length == 1) {
          lines = ['return ${_nullSafeCompareCall(fieldsList.single.name)};'];
        } else {
          lines = [
            'var value = ${_nullSafeCompareCall(fieldsList.first.name)};',
            for (var fieldName in fieldsList.skip(1).map((e) => e.name))
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

    classBuffer.writeln('}');
    yield classBuffer.toString();
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

const _hashMembers = r''' 
int _buildCompareHashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _buildCompareHashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
''';

const _nullSafeCompare = r'''
/// Handles comparing [a] and [b] if one or both of them are `null`.
///
/// If both values are `null`, `0` is returned.
/// If one value is `null`, it is sorted first.
/// If neither value is `null`, `a.compareTo(b)` is returned.
int _buildCompareNullSafeCompare(Comparable a, Comparable b) {
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
''';
