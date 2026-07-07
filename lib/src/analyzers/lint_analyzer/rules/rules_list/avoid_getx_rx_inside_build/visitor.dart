part of 'avoid_getx_rx_inside_build_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _expressions = <Expression>[];

  Iterable<Expression> get expressions => _expressions;

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    super.visitMethodDeclaration(node);

    if (node.name.lexeme != 'build' || !_returnsWidget(node)) {
      return;
    }

    final visitor = _RxCreationVisitor();
    node.body.visitChildren(visitor);

    _expressions.addAll(visitor.expressions);
  }

  bool _returnsWidget(MethodDeclaration node) {
    final type = node.returnType?.type;

    return type != null && hasWidgetType(type);
  }
}

class _RxCreationVisitor extends RecursiveAstVisitor<void> {
  static final _rxClassNamePattern = RegExp(r'^Rxn?([A-Z]\w*)?$');

  final _expressions = <Expression>[];

  Iterable<Expression> get expressions => _expressions;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);

    final typeName = node.staticType?.element?.name;
    if (typeName != null && _rxClassNamePattern.hasMatch(typeName)) {
      _expressions.add(node);
    }
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    super.visitPropertyAccess(node);

    if (node.propertyName.name == 'obs') {
      _expressions.add(node);
    }
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    super.visitPrefixedIdentifier(node);

    if (node.identifier.name == 'obs') {
      _expressions.add(node);
    }
  }
}
