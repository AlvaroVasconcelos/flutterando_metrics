// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../../../utils/flutter_types_utils.dart';
import '../../../../../utils/node_utils.dart';
import '../../../lint_utils.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/issue.dart';
import '../../../models/severity.dart';
import '../../models/getx_rule.dart';
import '../../rule_utils.dart';

part 'visitor.dart';

class AvoidGetxRxInsideBuildRule extends GetxRule {
  static const String ruleId = 'avoid-getx-rx-inside-build';

  static const _warningMessage =
      "Avoid using '.obs' or instantiating Rx primitives inside the 'build' "
      'method.';

  AvoidGetxRxInsideBuildRule([Map<String, Object> config = const {}])
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

    return visitor.expressions
        .map((expression) => createIssue(
              rule: this,
              location: nodeLocation(
                node: expression,
                source: source,
              ),
              message: _warningMessage,
            ))
        .toList(growable: false);
  }
}
