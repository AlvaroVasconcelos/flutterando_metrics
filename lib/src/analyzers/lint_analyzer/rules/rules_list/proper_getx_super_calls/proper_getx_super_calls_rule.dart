// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/getx_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class ProperGetxSuperCallsRule extends GetxRule {
  static const String ruleId = 'proper-getx-super-calls';

  static const _firstMessage = "This 'super' call must come first.";
  static const _lastMessage = "This 'super' call must come last.";

  ProperGetxSuperCallsRule([Map<String, Object> config = const {}])
      : super(
          id: ruleId,
          severity: readSeverity(config, Severity.warning),
          excludes: readExcludes(config),
          includes: readIncludes(config),
        );

  @override
  Iterable<Issue> check(InternalResolvedUnitResult source) {
    final visitor = _Visitor();

    source.unit.visitChildren(visitor);

    return visitor.wrongSuperCalls
        .map((wrongCall) => createIssue(
              rule: this,
              location: nodeLocation(
                node: wrongCall.invocation,
                source: source,
              ),
              message: wrongCall.shouldBeFirst ? _firstMessage : _lastMessage,
            ))
        .toList(growable: false);
  }
}
