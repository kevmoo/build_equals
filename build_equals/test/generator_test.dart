import 'package:build_equals/src/build_equals_generator.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'test_inputs'),
    'generator_test_input.dart',
  );

  testAnnotatedElements(
    reader,
    const BuildEqualsGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );
}

const _expectedAnnotatedTests = [
  'notAClass',
  'AllDisabled',
  'EmptyClass',
  'NoComparableField',
];
