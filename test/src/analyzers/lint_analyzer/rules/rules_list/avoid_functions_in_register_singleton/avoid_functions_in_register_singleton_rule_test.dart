import 'package:flutterando_metrics/src/analyzers/lint_analyzer/models/severity.dart';
import 'package:flutterando_metrics/src/analyzers/lint_analyzer/rules/rules_list/avoid_functions_in_register_singleton/avoid_functions_in_register_singleton_rule.dart';
import 'package:test/test.dart';

import '../../../../../helpers/rule_test_helper.dart';

const _examplePath =
    'avoid_functions_in_register_singleton/examples/example.dart';
const _noIssuesExamplePath =
    'avoid_functions_in_register_singleton/examples/no_issues_example.dart';

void main() {
  group('AvoidFunctionsInRegisterSingletonRule', () {
    test('initialization', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidFunctionsInRegisterSingletonRule().check(unit);

      RuleTestHelper.verifyInitialization(
        issues: issues,
        ruleId: 'avoid-functions-in-register-singleton',
        severity: Severity.warning,
      );
    });

    test('reports about found issues', () async {
      final unit = await RuleTestHelper.resolveFromFile(_examplePath);
      final issues = AvoidFunctionsInRegisterSingletonRule().check(unit);

      RuleTestHelper.verifyIssues(
        issues: issues,
        startLines: [2, 3, 6, 7, 8],
        startColumns: [3, 3, 3, 3, 3],
        locationTexts: [
          'GetIt.I.registerSingleton(() => SomeClass())',
          'GetIt.instance.registerSingleton(() => SomeClass())',
          'getIt.registerSingleton(() => SomeClass())',
          'getIt.registerSingleton(SomeClass.new)',
          'getIt.registerSingleton(_createInstance)',
        ],
        messages: [
          "Passing a function to 'registerSingleton' may produce unexpected results. Try passing an object instance, or use 'registerFactory' or 'registerLazySingleton' instead.",
          "Passing a function to 'registerSingleton' may produce unexpected results. Try passing an object instance, or use 'registerFactory' or 'registerLazySingleton' instead.",
          "Passing a function to 'registerSingleton' may produce unexpected results. Try passing an object instance, or use 'registerFactory' or 'registerLazySingleton' instead.",
          "Passing a function to 'registerSingleton' may produce unexpected results. Try passing an object instance, or use 'registerFactory' or 'registerLazySingleton' instead.",
          "Passing a function to 'registerSingleton' may produce unexpected results. Try passing an object instance, or use 'registerFactory' or 'registerLazySingleton' instead.",
        ],
      );
    });

    test('reports no issues for correct registrations', () async {
      final unit = await RuleTestHelper.resolveFromFile(_noIssuesExamplePath);
      final issues = AvoidFunctionsInRegisterSingletonRule().check(unit);

      RuleTestHelper.verifyNoIssues(issues);
    });
  });
}
