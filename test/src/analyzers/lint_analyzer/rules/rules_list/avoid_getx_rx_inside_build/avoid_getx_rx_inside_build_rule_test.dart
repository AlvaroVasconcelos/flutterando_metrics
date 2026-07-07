import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/avoid_getx_rx_inside_build/avoid_getx_rx_inside_build_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath = 'avoid_getx_rx_inside_build/examples/example.dart';
const _correctExamplePath =
    'avoid_getx_rx_inside_build/examples/correct_example.dart';

void main() {
  group('AvoidGetxRxInsideBuildRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidGetxRxInsideBuildRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'avoid-getx-rx-inside-build',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidGetxRxInsideBuildRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [56, 57, 58, 59, 60, 61],
        startColumns: [19, 18, 19, 19, 21, 22],
        locationTexts: [
          '0.obs',
          "'name'.obs",
          '<String>[].obs',
          'RxInt(1)',
          'Rx<int>(0)',
          'Rxn<String>()',
        ],
        messages: [
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
          "Avoid using '.obs' or instantiating Rx primitives inside the 'build' method.",
        ],
      );
    });

    test('reports no issues for fields and non-build methods', () async {
      final unit = await RuleTestHelper.resolveFromFile(_correctExamplePath);
      final issues = AvoidGetxRxInsideBuildRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
