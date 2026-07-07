import 'rule.dart';
import 'rule_type.dart';

/// Represents a base class for GetIt-specific rules.
/// link: https://pub.dev/packages/get_it
abstract class GetItRule extends Rule {
  const GetItRule({
    required super.id,
    required super.severity,
    required super.excludes,
    required super.includes,
  }) : super(
          type: RuleType.getIt,
        );
}
