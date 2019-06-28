// ignore_for_file: implementation_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/resolver/inheritance_manager.dart'
    show InheritanceManager; // ignore: deprecated_member_use
import 'package:source_gen/source_gen.dart';

/// Returns a [Set] of all instance [FieldElement] items for [element] and
/// super classes, sorted first by their location in the inheritance hierarchy
/// (super first) and then by their location in the source file.
Set<FieldElement> createSortedFieldSet(ClassElement element) {
  // Get all of the fields that need to be assigned
  final fieldsList = element.fields.where((e) => !e.isStatic).toList();

  final manager =
      InheritanceManager(element.library); // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  for (var v in manager.getMembersInheritedFromClasses(element).values) {
    assert(v is! FieldElement);
    if (_dartCoreObjectChecker.isExactly(v.enclosingElement)) {
      continue;
    }

    if (v is PropertyAccessorElement && v.variable is FieldElement) {
      fieldsList.add(v.variable as FieldElement);
    }
  }

  fieldsList
    ..removeWhere((e) => e.name == 'hashCode')
    // Sort these in the order in which they appear in the class
    // Sadly, `classElement.fields` puts properties after fields
    ..sort(_sortByLocation);

  return fieldsList.toSet();
}

int _sortByLocation(FieldElement a, FieldElement b) {
  final checkerA = TypeChecker.fromStatic(a.enclosingElement.type);

  if (!checkerA.isExactly(b.enclosingElement)) {
    // in this case, you want to prioritize the enclosingElement that is more
    // "super".

    if (checkerA.isSuperOf(b.enclosingElement)) {
      return -1;
    }

    final checkerB = TypeChecker.fromStatic(b.enclosingElement.type);

    if (checkerB.isSuperOf(a.enclosingElement)) {
      return 1;
    }
  }

  /// Returns the offset of given field/property in its source file – with a
  /// preference for the getter if it's defined.
  int _offsetFor(FieldElement e) {
    if (e.getter != null && e.getter.nameOffset != e.nameOffset) {
      assert(e.nameOffset == -1);
      return e.getter.nameOffset;
    }
    return e.nameOffset;
  }

  return _offsetFor(a).compareTo(_offsetFor(b));
}

const _dartCoreObjectChecker = TypeChecker.fromUrl('dart:core#Object');
