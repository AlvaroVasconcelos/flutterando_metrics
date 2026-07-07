// ignore_for_file: unused_element, cascade_invocations

class Widget {
  const Widget();
}

class BuildContext {
  const BuildContext();
}

abstract class State<T> {
  Widget build(BuildContext context);
}

class Rx<T> {
  Rx(this.value);

  T value;
}

class RxInt extends Rx<int> {
  RxInt(super.value);
}

class RxString extends Rx<String> {
  RxString(super.value);
}

class RxList<T> extends Rx<List<T>> {
  RxList(super.value);
}

class Rxn<T> extends Rx<T?> {
  Rxn([T? value]) : super(value);
}

extension IntObs on int {
  RxInt get obs => RxInt(this);
}

extension StringObs on String {
  RxString get obs => RxString(this);
}

extension ListObs<T> on List<T> {
  RxList<T> get obs => RxList<T>(this);
}

class Some extends Widget {
  const Some();
}

class _SomeState extends State<Some> {
  @override
  Widget build(BuildContext context) {
    final count = 0.obs; // LINT
    final name = 'name'.obs; // LINT
    final items = <String>[].obs; // LINT
    final typed = RxInt(1); // LINT
    final generic = Rx<int>(0); // LINT
    final nullable = Rxn<String>(); // LINT

    count.value += name.value.length + items.value.length;
    count.value += typed.value + generic.value;
    nullable.value = null;

    return const Widget();
  }
}
