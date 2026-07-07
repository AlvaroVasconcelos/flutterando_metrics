import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/proper_getx_super_calls/proper_getx_super_calls_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'proper_getx_super_calls/examples/example.dart';
const _correctExamplePath =
    'proper_getx_super_calls/examples/correct_order_example.dart';

void main() {
  group('ProperGetxSuperCallsRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = ProperGetxSuperCallsRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'proper-getx-super-calls',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = ProperGetxSuperCallsRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [6, 13, 20, 25, 32, 49],
        startColumns: [5, 5, 5, 5, 5, 5],
        locationTexts: [
          'super.onInit()',
          'super.onReady()',
          'super.onStart()',
          'super.onClose()',
          'super.onDelete()',
          'super.onInit()',
        ],
        messages: [
          "This 'super' call must come first.",
          "This 'super' call must come first.",
          "This 'super' call must come first.",
          "This 'super' call must come last.",
          "This 'super' call must come last.",
          "This 'super' call must come first.",
        ],
      );
    });

    test('should report no issues for correct super calls order', () async {
      final unit = await RuleTestHelper.resolveFromFile(_correctExamplePath);
      final issues = ProperGetxSuperCallsRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
