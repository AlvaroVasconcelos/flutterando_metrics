part of 'avoid_mutable_rx_variables_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  static final _rxTypeNamePattern = RegExp(r'^Rxn?([A-Z]\w*)?$');

  final _declarations = <VariableDeclaration>[];

  Iterable<VariableDeclaration> get declarations => _declarations;

  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    super.visitVariableDeclarationList(node);

    if (node.isFinal || node.isConst) {
      return;
    }

    if (_isRxType(node.type)) {
      _declarations.addAll(node.variables);

      return;
    }

    for (final variable in node.variables) {
      final initializerType = variable.initializer?.staticType;
      if (initializerType != null &&
          _matchesRxTypeName(initializerType.element?.name)) {
        _declarations.add(variable);
      }
    }
  }

  bool _isRxType(TypeAnnotation? type) =>
      type != null && _matchesRxTypeName(type.type?.element?.name);

  bool _matchesRxTypeName(String? name) =>
      name != null && _rxTypeNamePattern.hasMatch(name);
}
