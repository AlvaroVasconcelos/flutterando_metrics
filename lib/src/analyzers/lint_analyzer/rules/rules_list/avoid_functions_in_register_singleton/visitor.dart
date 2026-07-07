part of 'avoid_functions_in_register_singleton_rule.dart';

class _Visitor extends RecursiveAstVisitor<void> {
  final _invocations = <MethodInvocation>[];

  Iterable<MethodInvocation> get invocations => _invocations;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);

    if (node.methodName.name != 'registerSingleton') {
      return;
    }

    final target = node.realTarget;
    if (target == null || !_isGetIt(target.staticType)) {
      return;
    }

    final argument = node.argumentList.arguments
        .firstWhereOrNull((argument) => argument is! NamedExpression);
    if (argument == null) {
      return;
    }

    if (argument is FunctionExpression || argument.staticType is FunctionType) {
      _invocations.add(node);
    }
  }

  bool _isGetIt(DartType? type) =>
      type is InterfaceType && type.element.name == 'GetIt';
}
