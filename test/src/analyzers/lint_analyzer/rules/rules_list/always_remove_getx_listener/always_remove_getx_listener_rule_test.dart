import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/always_remove_getx_listener/always_remove_getx_listener_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'always_remove_getx_listener/examples/example.dart';
const _correctExamplePath =
    'always_remove_getx_listener/examples/correct_example.dart';

void main() {
  group('AlwaysRemoveGetxListenerRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AlwaysRemoveGetxListenerRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'always-remove-getx-listener',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AlwaysRemoveGetxListenerRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [12, 13, 21],
        startColumns: [5, 5, 5],
        locationTexts: [
          '_anotherListener.addListener(listener)',
          '_thirdListener.addListener(listener)',
          '_anotherListener.addListener(listener)',
        ],
        messages: [
          'Listener is not removed. This might lead to a memory leak.',
          'Listener is not removed. This might lead to a memory leak.',
          'Listener is not removed. This might lead to a memory leak.',
        ],
      );
    });

    test('should report no issues for properly removed listeners', () async {
      final unit = await RuleTestHelper.resolveFromFile(_correctExamplePath);
      final issues = AlwaysRemoveGetxListenerRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
