part of 'dispose_getx_fields_rule.dart';

const _getxTeardownClasses = {
  'GetxController',
  'GetxService',
  'SuperController',
  'FullLifeCycleController',
  'DisposableInterface',
};

class _Visitor extends RecursiveAstVisitor<void> {
  final _undisposedFields = <VariableDeclaration>[];

  Iterable<VariableDeclaration> get undisposedFields => _undisposedFields;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);

    if (!_isGetxClass(node.extendsClause?.superclass.type)) {
      return;
    }

    final disposableFields = <VariableDeclaration>[];
    for (final member in node.members) {
      if (member is FieldDeclaration && !member.isStatic) {
        for (final variable in member.fields.variables) {
          if (variable.initializer != null && _hasDisposeMethod(variable)) {
            disposableFields.add(variable);
          }
        }
      }
    }

    if (disposableFields.isEmpty) {
      return;
    }

    final disposedNames = <String>{};
    for (final member in node.members) {
      if (member is MethodDeclaration && member.name.lexeme == 'onClose') {
        final visitor = _DisposeInvocationVisitor();
        member.visitChildren(visitor);
        disposedNames.addAll(visitor.disposedNames);
      }
    }

    _undisposedFields.addAll(
      disposableFields
          .where((field) => !disposedNames.contains(field.name.lexeme)),
    );
  }

  bool _isGetxClass(DartType? type) =>
      _isGetxTeardownType(type) ||
      (type is InterfaceType && type.allSupertypes.any(_isGetxTeardownType));

  bool _isGetxTeardownType(DartType? type) => _getxTeardownClasses
      .contains(type?.getDisplayString(withNullability: false));

  bool _hasDisposeMethod(VariableDeclaration variable) {
    final type = variable.declaredElement?.type;

    return type is InterfaceType &&
        [type, ...type.allSupertypes].any(
          (interfaceType) =>
              interfaceType.methods.any((method) => method.name == 'dispose'),
        );
  }
}

class _DisposeInvocationVisitor extends RecursiveAstVisitor<void> {
  final _disposedNames = <String>{};

  Iterable<String> get disposedNames => _disposedNames;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (node.methodName.name != 'dispose') {
      return;
    }

    final target = node.realTarget;
    if (target is SimpleIdentifier) {
      _disposedNames.add(target.name);
    } else if (target is PrefixedIdentifier) {
      _disposedNames.add(target.identifier.name);
    } else if (target is PropertyAccess) {
      _disposedNames.add(target.propertyName.name);
    }
  }
}
