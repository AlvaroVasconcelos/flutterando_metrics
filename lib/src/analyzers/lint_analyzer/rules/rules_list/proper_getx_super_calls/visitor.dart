part of 'proper_getx_super_calls_rule.dart';

const _superFirstMethods = {'onInit', 'onReady', 'onStart'};
const _superLastMethods = {'onClose', 'onDelete'};

const _getxBaseClasses = {
  'GetxController',
  'GetxService',
  'SuperController',
  'FullLifeCycleController',
  'DisposableInterface',
};

class _Visitor extends RecursiveAstVisitor<void> {
  final _wrongSuperCalls = <_SuperCallInfo>[];

  Iterable<_SuperCallInfo> get wrongSuperCalls => _wrongSuperCalls;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    final type = node.extendsClause?.superclass.type;
    if (!_isGetxClassOrSubclass(type)) {
      return;
    }

    for (final member in node.members) {
      if (member is! MethodDeclaration) {
        continue;
      }

      final name = member.name.lexeme;
      final shouldBeFirst = _superFirstMethods.contains(name);
      if (!shouldBeFirst && !_superLastMethods.contains(name)) {
        continue;
      }

      final body = member.body;
      if (body is! BlockFunctionBody) {
        continue;
      }

      final statements = body.block.statements;
      final superIndex =
          statements.indexWhere((statement) => _isSuperCall(statement, name));
      if (superIndex == -1) {
        continue;
      }

      final expectedIndex = shouldBeFirst ? 0 : statements.length - 1;
      if (superIndex != expectedIndex) {
        final statement = statements[superIndex] as ExpressionStatement;
        _wrongSuperCalls.add(
          _SuperCallInfo(statement.expression, shouldBeFirst: shouldBeFirst),
        );
      }
    }
  }

  bool _isSuperCall(Statement statement, String methodName) {
    if (statement is! ExpressionStatement) {
      return false;
    }

    final expression = statement.expression;

    return expression is MethodInvocation &&
        expression.target is SuperExpression &&
        expression.methodName.name == methodName;
  }

  bool _isGetxClassOrSubclass(DartType? type) =>
      type != null &&
      (_getxBaseClasses.contains(type.element?.name) ||
          (type is InterfaceType &&
              type.allSupertypes.any(
                (supertype) =>
                    _getxBaseClasses.contains(supertype.element.name),
              )));
}

class _SuperCallInfo {
  final Expression invocation;
  final bool shouldBeFirst;

  const _SuperCallInfo(this.invocation, {required this.shouldBeFirst});
}
