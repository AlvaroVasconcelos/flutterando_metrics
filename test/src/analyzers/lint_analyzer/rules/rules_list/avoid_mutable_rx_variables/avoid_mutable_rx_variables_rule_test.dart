import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/avoid_mutable_rx_variables/avoid_mutable_rx_variables_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'avoid_mutable_rx_variables/examples/example.dart';
const _correctExamplePath =
    'avoid_mutable_rx_variables/examples/correct_example.dart';

void main() {
  group('AvoidMutableRxVariablesRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidMutableRxVariablesRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'avoid-mutable-rx-variables',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidMutableRxVariablesRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [1, 4, 5, 6, 7, 8, 9, 13, 14],
        startColumns: [7, 11, 18, 17, 25, 7, 7, 9, 13],
        locationTexts: [
          'topLevelCounter = RxInt(0)',
          'rx = Rx<int>(0)',
          'list = <String>[].obs',
          'set = <String>{}.obs',
          'map = <String, String>{}.obs',
          'inferred = RxBool(false)',
          'counter = 0.obs',
          'count = RxInt(0)',
          'name = RxnString()',
        ],
        messages: [
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
          'Avoid declaring mutable Rx variables. Try making it final instead.',
        ],
      );
    });

    test('reports no issues for final declarations and non-Rx types', () async {
      final unit = await RuleTestHelper.resolveFromFile(_correctExamplePath);
      final issues = AvoidMutableRxVariablesRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
