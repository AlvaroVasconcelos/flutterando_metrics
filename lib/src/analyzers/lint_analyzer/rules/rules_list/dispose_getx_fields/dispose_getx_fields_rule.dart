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

class DisposeGetxFieldsRule extends GetxRule {
  static const String ruleId = 'dispose-getx-fields';

  static const _warningMessage =
      'This field is not disposed, which can lead to a memory leak. '
      "Try disposing this field in the 'onClose' method.";

  DisposeGetxFieldsRule([Map<String, Object> config = const {}])
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

    return visitor.undisposedFields
        .map((field) => createIssue(
              rule: this,
              location: nodeLocation(
                node: field,
                source: source,
              ),
              message: _warningMessage,
            ))
        .toList(growable: false);
  }
}
