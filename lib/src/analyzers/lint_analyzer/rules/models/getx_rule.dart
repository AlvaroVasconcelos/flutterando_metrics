import 'rule.dart';
import 'rule_type.dart';

/// Represents a base class for GetX-specific rules.
/// link: https://pub.dev/packages/get
abstract class GetxRule extends Rule {
  const GetxRule({
    required super.id,
    required super.severity,
    required super.excludes,
    required super.includes,
  }) : super(
          type: RuleType.getx,
        );
}
