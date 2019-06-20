import 'package:build_compare/src/build_compare_generator.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';

void main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'src'),
    'generator_test_input.dart',
  );

  testAnnotatedElements(
    reader,
    const BuildCompareGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );
}

const _expectedAnnotatedTests = [
  'EmptyClass',
  'OneFieldClass',
  'VagueFieldClass',
];
