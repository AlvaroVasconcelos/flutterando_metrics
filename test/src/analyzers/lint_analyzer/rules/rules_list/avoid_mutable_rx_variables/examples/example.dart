RxInt topLevelCounter = RxInt(0); // LINT

void fn() {
  Rx<int> rx = Rx<int>(0); // LINT
  RxList<String> list = <String>[].obs; // LINT
  RxSet<String> set = <String>{}.obs; // LINT
  RxMap<String, String> map = <String, String>{}.obs; // LINT
  var inferred = RxBool(false); // LINT
  var counter = 0.obs; // LINT
}

class SomeController {
  RxInt count = RxInt(0); // LINT
  RxnString name = RxnString(); // LINT
}

class Rx<T> {
  T value;
  Rx(this.value);
}

class Rxn<T> extends Rx<T?> {
  Rxn([T? value]) : super(value);
}

class RxInt extends Rx<int> {
  RxInt(super.value);
}

class RxBool extends Rx<bool> {
  RxBool(super.value);
}

class RxnString extends Rxn<String> {
  RxnString([super.value]);
}

class RxList<E> extends Rx<List<E>> {
  RxList(super.value);
}

class RxSet<E> extends Rx<Set<E>> {
  RxSet(super.value);
}

class RxMap<K, V> extends Rx<Map<K, V>> {
  RxMap(super.value);
}

extension IntExtension on int {
  RxInt get obs => RxInt(this);
}

extension ListExtension<E> on List<E> {
  RxList<E> get obs => RxList<E>(this);
}

extension SetExtension<E> on Set<E> {
  RxSet<E> get obs => RxSet<E>(this);
}

extension MapExtension<K, V> on Map<K, V> {
  RxMap<K, V> get obs => RxMap<K, V>(this);
}
