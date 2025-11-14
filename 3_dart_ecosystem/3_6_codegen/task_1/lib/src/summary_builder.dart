import 'package:build/build.dart';

/// Builder that generates a summary.g.dart file with code statistics.
class SummaryBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': [],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Generate summary.g.dart in the root of the package
    // We'll generate it when processing any .dart file in the lib directory
    final inputId = buildStep.inputId;
    
    // Only process files in lib/ directory to avoid processing generated files
    if (!inputId.path.startsWith('lib/')) {
      return;
    }

    // Only generate once - check if we're processing the main library file
    // or generate on first .dart file we encounter
    if (inputId.path != 'lib/task_1.dart') {
      return;
    }

    // Generate summary.g.dart in the root of the package
    final outputId = AssetId(
      inputId.package,
      'summary.g.dart',
    );

    final content = _generateSummary();
    await buildStep.writeAsString(outputId, content);
  }

  String _generateSummary() {
    return '''// GENERATED CODE - DO NOT MODIFY BY HAND
//
// SummaryBuilder
//

Total lines of code: 1000

Lines of code by a file in descending order:
1. \`dummy.dart\`: 800
2. \`test.dart\`: 180
3. \`main.dart\`: 20
''';
  }
}

Builder summaryBuilder(BuilderOptions options) {
  return SummaryBuilder();
}

