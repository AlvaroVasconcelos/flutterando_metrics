import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/dispose_getx_fields/dispose_getx_fields_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'dispose_getx_fields/examples/example.dart';
const _correctExamplePath = 'dispose_getx_fields/examples/correct_example.dart';

void main() {
  group('DisposeGetxFieldsRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = DisposeGetxFieldsRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'dispose-getx-fields',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = DisposeGetxFieldsRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [3, 4, 16],
        startColumns: [9, 9, 9],
        locationTexts: [
          '_anotherDisposable = AnotherDisposable()',
          '_thirdDisposable = SomeDisposable()',
          '_someDisposable = SomeDisposable()',
        ],
        messages: [
          'This field is not disposed, which can lead to a memory leak. '
              "Try disposing this field in the 'onClose' method.",
          'This field is not disposed, which can lead to a memory leak. '
              "Try disposing this field in the 'onClose' method.",
          'This field is not disposed, which can lead to a memory leak. '
              "Try disposing this field in the 'onClose' method.",
        ],
      );
    });

    test('reports no issues for disposed and non-disposable fields', () async {
      final unit = await RuleTestHelper.resolveFromFile(_correctExamplePath);
      final issues = DisposeGetxFieldsRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
